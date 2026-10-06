extends Node3D
class_name Track

# Properties
## D 8.1.1: the minimum track width is 3 m. The generator holds the centreline
## to the turning and length rules; this is the one it cannot, because it is a
## property of how the cones are laid out either side of that centreline.
@export var track_width : float = 3.0
## Distance between gates along the track, and so between cones down one side.
## The rules cap that at 5 m.
@export var track_spacing : float = 4.0
## How far behind the start line the car lines up, as the rules place it.
const START_OFFSET := 6.0

# ROS 2 Frame: X Forward (+Z), Y Left (+X), Z Up (+Y)
var track_curve : Curve3D = Curve3D.new() 
@onready var track_path : Path3D = $TrackPath



# Internal Refs
static var _gate_scene = preload("res://Scenes/Track/Gate/gate.tscn")
static var _cone_scene = preload("res://Scenes/Track/Cone/cone.tscn")

# Track Generator
var track_gen = TrackGenerator.new()
signal track_loaded

# ROS node to manage tracks
var _node: RosNode
var _track_pub : RosPublisher
var _map_pub : RosPublisher
var _map_timer : RosTimer
var _track_timer : RosTimer

# Standard ROS 2 Origin (X: Forward, Y: Left, PSI: Counter-Clockwise Yaw)
var origin : Transform3D 

# Parameter handling
func _on_ros_parameter_changed(param_name: String, value: Variant):
	if param_name == "track":
		if value == "random":
			create_track()
		else:
			if FileAccess.file_exists(value):
				load_track(value)
		


func _ready() -> void:
	_node = RosNode.new()
	_node.init("track_manager")
	# Track name parameter and callback
	_node.declare_parameter("track", "")
	_node.parameter_changed.connect(_on_ros_parameter_changed)
	# Publishers
	_track_pub = _node.create_publisher("~/track","mirena_common/msg/Track")
	_map_pub = _node.create_publisher("~/full_map","mirena_common/msg/EntityList")
	# Timers for publishers
	_map_timer = _node.create_timer(1,_publish_full_map)
	_track_timer = _node.create_timer(1,_publish_track)
	
	#Check parameter
	var value = _node.get_parameter("track")
	if value == "random":
		create_track()
	else:
		if FileAccess.file_exists(value):
			load_track(value)
	

	
# ROS publishers
func _publish_full_map():
	var msg = RosMirenaCommonEntityList.new()
	msg.header.frame_id = "debug_map"
	msg.header.stamp = _node.now()
	msg.entities = get_tree().get_nodes_in_group("Cones").map(func(c): return _to_ent(c,true))
	_map_pub.publish(msg)


func _publish_track():
	if not Sim.track: return
	var msg = RosMirenaCommonTrack.new()
	msg.header.frame_id = "debug_map"
	msg.header.stamp = _node.now()
	msg.is_closed = track_curve.closed
	msg.gates = get_gate_positions().map(func(t: Transform3D):
		var gate = RosMirenaCommonGate.new()
		gate.x = -t.origin.z  # Godot -Z Forward -> ROS +X
		gate.y = -t.origin.x  # Godot -X Left    -> ROS +Y
		gate.psi = -t.basis.get_euler(EulerOrder.EULER_ORDER_YXZ).x
		
		return gate
	)
	_track_pub.publish(msg)
	
func _to_ent(cone: Node3D, global : bool = false  ) -> RosMirenaCommonEntity:
	var ent = RosMirenaCommonEntity.new()
	var pos =  cone.global_position if global else to_local(cone.global_position)
	ent.type = cone.get_type_as_string()
	
	# ROS Swizzle: Forward=Z, Left=-X, Up=Y
	ent.position.x = -pos.z
	ent.position.y = -pos.x
	ent.position.z = pos.y
	return ent
	
func create_track():
	clear_track()
	# Update curve and path
	track_curve = track_gen.generate()
	track_path.curve = track_curve
	var stats: Dictionary = track_gen.last_stats
	print("Track: %.0f m lap, tightest turn %.1f m radius, longest straight %.0f m (%d attempts%s)" % [
		stats.get("lap_length", 0.0), stats.get("min_turn_radius", 0.0),
		stats.get("longest_straight", 0.0), stats.get("attempts", 0),
		", fallback" if stats.get("fallback", false) else ""])
	
	var length = track_curve.get_baked_length()
	var num_gates = int(length / track_spacing)

	for i in range(0, num_gates):
		var d = (i * track_spacing)
		var gate = _gate_scene.instantiate() as Gate
		$Gates.add_child(gate) 
		
		gate.gate_width = track_width
		gate.gate_type = Gate.GateType.EVENT if (i == 0) else Gate.GateType.STANDARD
		
		var trans = track_curve.sample_baked_with_rotation(d, true)
		gate.global_transform = trans
		gate.rotate_object_local(Vector3.UP, PI)

	# --- Shifted Origin Logic ---
	var p0 = track_curve.get_point_position(0)
	var p1 = track_curve.get_point_position(1)
	var dir = (p0 - p1).normalized()

	# The car lines up 6 m behind the start line, as the rules place it, so the
	# run begins with the line ahead rather than under the front axle. Perception
	# and SLAM both start from here, and the map frame is this pose -- which is
	# what lets the planner treat the origin as the track root.
	var shifted_p0 = p0 + (dir * START_OFFSET)

	origin.origin = shifted_p0
	origin.basis = Basis.looking_at(dir, Vector3.UP, true)
	
	track_loaded.emit()

## Writes the current track out in the format load_track reads, which is also
## the format the planner's stored templates are in.
##
## Everything is in the ROS frame the rest of the stack works in -- x forward,
## y left, measured from the car's start pose -- so an exported track drops
## straight into a planner test with no transform.
func export_track(path: String) -> bool:
	var to_start := origin.affine_inverse()

	var cones := []
	for cone in get_tree().get_nodes_in_group("Cones"):
		var p = to_start * cone.global_position
		cones.append({
			"type": cone.get_type_as_string(),
			"x": snappedf(-p.z, 0.001),
			"y": snappedf(-p.x, 0.001)})

	var points := []
	var length := track_curve.get_baked_length()
	var walked := 0.0
	while walked < length:
		var p = to_start * track_curve.sample_baked(walked)
		points.append({"x": snappedf(-p.z, 0.001), "y": snappedf(-p.x, 0.001)})
		walked += track_spacing

	# The car sits at the origin of its own start frame by construction, so the
	# pose is only here because the format carries it.
	var data := {
		"metadata": {
			"track_name": path.get_file().get_basename(),
			"description": "Generated by mirena_sim",
			"date": Time.get_date_string_from_system()},
		"setup": {"car_start_pose": {"x": 0.0, "y": 0.0, "psi": 0.0}},
		"cones": cones,
		"path": {"closed": track_curve.closed, "points": points}}

	var file = FileAccess.open(path, FileAccess.WRITE)
	if not file:
		push_error("Track: cannot write %s" % path)
		return false
	file.store_string(JSON.stringify(data, "  "))
	return true


func load_track(path : String):
	clear_track()
	var file = FileAccess.open(path, FileAccess.READ)
	if not file: return
	
	var json = JSON.new()
	json.parse(file.get_as_text())
	var data = json.data
	
	# Load Cones: ROS X -> Godot Z | ROS Y -> Godot X
	if data.has("cones"):
		for cone_data in data["cones"]:
			var cone = _cone_scene.instantiate() as Cone
			# ROS X is -Z, ROS Y is -X
			cone.position = Vector3(-cone_data["y"], 0.0, -cone_data["x"])
			
			match cone_data["type"]:
				"cone_blue": cone.type = Cone.ConeColor.BLUE
				"cone_yellow": cone.type = Cone.ConeColor.YELLOW
				"cone_orange": cone.type = Cone.ConeColor.ORANGE
				"cone_big_orange": cone.type = Cone.ConeColor.BIG_ORANGE
			
			cone.add_to_group("Cones")
			cone.rotation.y = randf_range(0, PI/2)
			$Gates.add_child(cone)

	if data.has('path'):
		track_curve.clear_points()
		for p in data['path']['points']:
			# Mapping ROS path points back to Godot space, the same way the
			# cones and the origin above are mapped: ROS X is -Z, ROS Y is -X.
			track_curve.add_point(Vector3(-p['y'], 0.0, -p['x']))
			track_curve.closed = data['path']['closed']

	# Start pose directly assigned from ROS 2 input

	origin.origin = Vector3(-data.setup.car_start_pose.y,0.0,-data.setup.car_start_pose.x)
	origin.basis = Basis(Vector3.UP, data.setup.car_start_pose.psi)
	track_loaded.emit()

func clear_track():
	for n in $Gates.get_children(): n.queue_free()

func get_gate_positions() -> Array[Transform3D]:
	var length = track_curve.get_baked_length()
	var num_points = int(length / track_spacing)
	var transforms: Array[Transform3D] = []
	
	for i in range(0, num_points):
		var d = (i * track_spacing)
		var pos = track_curve.sample_baked(d)
		
		# Get direction vector by looking slightly ahead
		var next_d = fmod(d + 0.1, length)
		var next_pos = track_curve.sample_baked(next_d)
		var dir = (next_pos - pos).normalized()
		
		# Construct the Transform3D
		var gate_xform = Transform3D()
		gate_xform.origin = pos
		# use_model_front = true enforces Godot's native -Z as forward
		gate_xform.basis = Basis.looking_at(dir, Vector3.UP, true)
		
		transforms.append(gate_xform)
		
	return transforms
