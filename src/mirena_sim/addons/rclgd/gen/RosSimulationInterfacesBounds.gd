extends RosMsg
class_name RosSimulationInterfacesBounds

func _init():
	init("simulation_interfaces/msg/Bounds")

var type : int:
	get: return get_member(&"type")
	set(v): set_member(&"type", v)

var points : Array:
	get: return get_member(&"points")
	set(v): set_member(&"points", v)

