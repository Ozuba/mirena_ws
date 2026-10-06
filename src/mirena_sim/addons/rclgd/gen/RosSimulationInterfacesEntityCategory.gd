extends RosMsg
class_name RosSimulationInterfacesEntityCategory

func _init():
	init("simulation_interfaces/msg/EntityCategory")

var category : int:
	get: return get_member(&"category")
	set(v): set_member(&"category", v)

