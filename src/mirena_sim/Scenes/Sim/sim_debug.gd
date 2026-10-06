extends Node

# --- Estado Interno ---
var _node: RosNode
var _tasks: Array[PublishTask] = []
var slam_cones: Array = []
var car_frame = "cog"

func _ready() -> void:
	_setup_ros_system()
	if Sim.has_signal("track_loaded"):
		Sim.track_loaded.connect(func(): slam_cones.clear())

func _setup_ros_system() -> void:
	_node = RosNode.new()
	_node.init("SimDebug")
	
	_tasks.append(PublishTask.new("control",  50.0, _node.create_publisher("/sim/debug/control",        "mirena_common/msg/CarControl"),      _publish_control))
	_tasks.append(PublishTask.new("slam",     10.0, _node.create_publisher("/sim/debug/slam",           "mirena_common/msg/EntityList"),      _publish_slam))
	_tasks.append(PublishTask.new("map",      1.0,  _node.create_publisher("/sim/debug/full_map",       "mirena_common/msg/EntityList"),      _publish_full_map))
	_tasks.append(PublishTask.new("track",    1.0,  _node.create_publisher("/sim/debug/track",          "mirena_common/msg/Track"),           _publish_track))
	

func _physics_process(delta: float) -> void:
	if not Sim.car: return
	for task in _tasks:
		task.tick(delta)

# --- Callbacks (Ahora reciben su propio publisher por argumento) ---
func _publish_car_state(pub: RosPublisher):
	var msg = RosMirenaCommonCar.new()
	msg.header.stamp = _node.now()
	msg.header.frame_id = "map"
	msg.x = Sim.car.global_position.z
	msg.y = Sim.car.global_position.x
	msg.psi = Sim.car.global_rotation.y
	
	var local_vel = Sim.car.basis.inverse() * Sim.car.linear_velocity
	msg.u = local_vel.z; msg.v = local_vel.x; msg.omega = Sim.car.angular_velocity.y
	pub.publish(msg)


func _process_debug_perception(pub: RosPublisher):
	var cones = Sim.car.get_cones_in_sight()
	for cone in cones:
		if not slam_cones.has(cone): slam_cones.append(cone)
	
	var msg = RosMirenaCommonDebugEntityList.new()
	msg.header.frame_id = car_frame
	msg.header.stamp = _node.now()
	msg.entities = cones.map(func(c): return _to_deb_ent(c, Sim.car))
	pub.publish(msg)

func _publish_slam(pub: RosPublisher):
	var msg = RosMirenaCommonEntityList.new()
	msg.header.frame_id = "map"
	msg.header.stamp = _node.now()
	slam_cones = slam_cones.filter(func(c): return is_instance_valid(c))
	msg.entities = slam_cones.map(func(c): return _to_ent(c))
	pub.publish(msg)

func _publish_full_map(pub: RosPublisher):
	var msg = RosMirenaCommonEntityList.new()
	msg.header.frame_id = "map"
	msg.header.stamp = _node.now()
	msg.entities = get_tree().get_nodes_in_group("Cones").map(func(c): return _to_ent(c))
	pub.publish(msg)


func _publish_track(pub: RosPublisher):
	if not Sim.track: return
	var msg = RosMirenaCommonTrack.new()
	msg.header.frame_id = "map"
	msg.header.stamp = _node.now()
	msg.is_closed = Sim.track.track_curve.closed
	msg.gates = Sim.track.get_gate_positions().map(func(gp):
		var gate = RosMirenaCommonGate.new()
		gate.x = gp.x; gate.y = gp.y; gate.psi = gp.psi
		return gate
	)
	pub.publish(msg)

func _publish_control(pub: RosPublisher):
	var msg = RosMirenaCommonCarControl.new()
	msg.header.frame_id = "map"
	msg.header.stamp = _node.now()
	msg.gas = Sim.car.gas; msg.steer_angle = Sim.car.steering
	pub.publish(msg)

# --- Helper ---
## Convierte un cono a mensaje de ROS, opcionalmente relativo a un frame (nodo)
func _to_ent(cone: Node3D, reference_frame: Node3D = null) -> RosMirenaCommonEntity:
	var ent = RosMirenaCommonEntity.new()
	
	# Obtenemos la posición inicial (global)
	var pos: Vector3 = cone.global_position
	
	# Si se proporciona un frame de referencia, transformamos la posición a local
	if is_instance_valid(reference_frame):
		pos = reference_frame.to_local(pos)
	
	# Mapeo de ejes Godot -> ROS 
	# -Godot Z (Forward) -> ROS X
	# -Godot X (Lateral) -> ROS Y
	# Godot Y (Up)      -> ROS Z
	ent.position.x = -pos.z
	ent.position.y = -pos.x
	ent.position.z = pos.y
	
	ent.type = cone.get_type_as_string()
	return ent

# --- Helper ---
## Convierte un cono a mensaje de ROS con informacion extra
func _to_deb_ent(cone: Node3D, reference_frame: Node3D = null) -> RosMirenaCommonDebugEntity:
	var ent = RosMirenaCommonEntity.new()
	
	# Obtenemos la posición inicial (global)
	var global_pos: Vector3 = cone.global_position
	
	# Si se proporciona un frame de referencia, transformamos la posición a local
	var pos
	if is_instance_valid(reference_frame):
		pos = reference_frame.to_local(global_pos)
	
	# Mapeo de ejes Godot -> ROS 
	# Godot Z (Forward) -> ROS X
	# Godot X (Lateral) -> ROS Y
	# Godot Y (Up)      -> ROS Z
	ent.position.x = -pos.z
	ent.position.y = -pos.x
	ent.position.z = pos.y
	
	ent.type = cone.get_type_as_string()
	
	var deb_ent = RosMirenaCommonDebugEntity.new()
	deb_ent.ent = ent
	deb_ent.debug_id = cone.get_instance_id()
	deb_ent.debug_real_position.x = -global_pos.z
	deb_ent.debug_real_position.y = -global_pos.x
	deb_ent.debug_real_position.z = global_pos.y
	return deb_ent
