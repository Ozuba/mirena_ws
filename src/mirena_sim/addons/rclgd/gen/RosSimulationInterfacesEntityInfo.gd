extends RosMsg
class_name RosSimulationInterfacesEntityInfo

func _init():
	init("simulation_interfaces/msg/EntityInfo")

var category : RosSimulationInterfacesEntityCategory:
	get: return get_member(&"category") as RosMsg
	set(v): set_member(&"category", v)

var description : String:
	get: return get_member(&"description")
	set(v): set_member(&"description", v)

var tags : PackedStringArray:
	get: return get_member(&"tags")
	set(v): set_member(&"tags", v)

