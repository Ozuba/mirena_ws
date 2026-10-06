@tool
extends Area3D
class_name Gate

signal vehicle_passed

enum GateType { 
	STANDARD, # Normal directional Gate
	EVENT,    # Race start Gate (4 cones)
}

# Preload your Cone scene - adjust the path to your actual .tscn
const CONE_SCENE = preload("res://Scenes/Track/Cone/cone.tscn")

@export var gate_width: float = 3.0:
	set(val):
		gate_width = val
		if is_inside_tree(): _update_layout()

@export var gate_type: GateType = GateType.STANDARD:
	set(val):
		gate_type = val
		if is_inside_tree(): _update_layout()

func _ready():
	_update_layout()
	if not Engine.is_editor_hint():
		body_entered.connect(_on_body_entered)

func _update_layout():
	# 1. Clear existing cones to avoid duplication
	for child in get_children():
		if child.is_in_group("cones") or child is MeshInstance3D or "Cone" in child.name:
			if child != $CollisionShape3D: # Keep the trigger box
				child.free()

	# 2. Spawn Cones based on Type
	match gate_type:
		GateType.STANDARD:
			_spawn_cone("RightCone", Vector3(-gate_width / 2.0, 0, 0), Cone.ConeColor.YELLOW)
			_spawn_cone("LeftCone", Vector3(gate_width / 2.0, 0, 0), Cone.ConeColor.BLUE)
			
		GateType.EVENT:
			# Event gates have two cones on each side (spaced slightly apart in Z)
			var z_offset = 0.3 
			_spawn_cone("LeftFrontCone",  Vector3(-gate_width / 2.0, 0, -z_offset), Cone.ConeColor.BIG_ORANGE)
			_spawn_cone("LeftBackCone",   Vector3(-gate_width / 2.0, 0,  z_offset), Cone.ConeColor.BIG_ORANGE)
			_spawn_cone("RightFrontCone", Vector3( gate_width / 2.0, 0, -z_offset), Cone.ConeColor.BIG_ORANGE)
			_spawn_cone("RightBackCone",  Vector3( gate_width / 2.0, 0,  z_offset), Cone.ConeColor.BIG_ORANGE)

	# 3. Update Collision Shape
	if has_node("CollisionShape3D"):
		$CollisionShape3D.shape.size = Vector3(gate_width, 3.0, 0.25)

func _spawn_cone(cone_name: String, pos: Vector3, color: int):
	var new_cone = CONE_SCENE.instantiate()
	new_cone.name = cone_name
	add_child(new_cone)
	new_cone.position = pos
	new_cone.type = color
	new_cone.add_to_group("Cones")

func _on_body_entered(body: Node3D):
	if body.is_in_group("vehicle"):
		# Forward in Godot is -Z. 
		var gate_forward = -global_transform.basis.z 
		# Check if the body has a linear_velocity property (typical for RigidBody3D)
		var velocity = body.linear_velocity if "linear_velocity" in body else Vector3.ZERO
		var vehicle_velocity = velocity.normalized()
		
		if gate_forward.dot(vehicle_velocity) > 0.1:
			print("Valid Pass!")
			vehicle_passed.emit()
		else:
			print("Wrong Way!")
