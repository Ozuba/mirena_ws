extends RosMsg
class_name RosSimulationInterfacesWorldResource

func _init():
	init("simulation_interfaces/msg/WorldResource")

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var world_resource : RosSimulationInterfacesResource:
	get: return get_member(&"world_resource") as RosMsg
	set(v): set_member(&"world_resource", v)

var description : String:
	get: return get_member(&"description")
	set(v): set_member(&"description", v)

var tags : PackedStringArray:
	get: return get_member(&"tags")
	set(v): set_member(&"tags", v)

