extends RosMsg
class_name RosSimulationInterfacesResource

func _init():
	init("simulation_interfaces/msg/Resource")

var uri : String:
	get: return get_member(&"uri")
	set(v): set_member(&"uri", v)

var resource_string : String:
	get: return get_member(&"resource_string")
	set(v): set_member(&"resource_string", v)

