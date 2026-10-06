extends RosMsg
class_name RosSimulationInterfacesResult

func _init():
	init("simulation_interfaces/msg/Result")

var result : int:
	get: return get_member(&"result")
	set(v): set_member(&"result", v)

var error_message : String:
	get: return get_member(&"error_message")
	set(v): set_member(&"error_message", v)

