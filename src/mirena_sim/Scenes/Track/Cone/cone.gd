@tool
extends Node3D
class_name Cone

signal collided_with_vehicle;

enum ConeColor {BLUE, YELLOW, ORANGE, BIG_ORANGE}
static var blue_mesh = preload("res://Assets/Models/Cone/Meshes/BCone.res")
static var yellow_mesh = preload("res://Assets/Models/Cone/Meshes/YCone.res")
static var orange_mesh = preload("res://Assets/Models/Cone/Meshes/OCone.res")
static var big_orange_mesh = preload("res://Assets/Models/Cone/Meshes/BOCone.res")

@export var type : ConeColor = ConeColor.BLUE:
	set(_type):
		type = _type
		match type:
			ConeColor.BLUE:
				$Model.mesh = blue_mesh
			ConeColor.YELLOW:
				$Model.mesh = yellow_mesh
			ConeColor.ORANGE:
				$Model.mesh = orange_mesh
			ConeColor.BIG_ORANGE:
				$Model.mesh = big_orange_mesh


func get_type_as_string() -> String:
	match type:
		ConeColor.BLUE:
			return "cone_blue"
		ConeColor.YELLOW:
			return "cone_yellow"
		ConeColor.ORANGE:
			return "cone_orange"
		ConeColor.BIG_ORANGE:
			return "cone_big_orange"
		_:
			return "Cone"
	

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("vehicle"):
		collided_with_vehicle.emit()
