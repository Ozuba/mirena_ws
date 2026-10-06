extends RosMsg
class_name RosSimulationInterfacesSpawnable

func _init():
	init("simulation_interfaces/msg/Spawnable")

var uri : String:
	get: return get_member(&"uri")
	set(v): set_member(&"uri", v)

var description : String:
	get: return get_member(&"description")
	set(v): set_member(&"description", v)

var spawn_bounds : RosSimulationInterfacesBounds:
	get: return get_member(&"spawn_bounds") as RosMsg
	set(v): set_member(&"spawn_bounds", v)

