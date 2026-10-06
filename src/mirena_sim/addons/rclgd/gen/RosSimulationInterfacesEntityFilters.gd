extends RosMsg
class_name RosSimulationInterfacesEntityFilters

func _init():
	init("simulation_interfaces/msg/EntityFilters")

var filter : String:
	get: return get_member(&"filter")
	set(v): set_member(&"filter", v)

var categories : Array:
	get: return get_member(&"categories")
	set(v): set_member(&"categories", v)

var tags : RosSimulationInterfacesTagsFilter:
	get: return get_member(&"tags") as RosMsg
	set(v): set_member(&"tags", v)

var bounds : RosSimulationInterfacesBounds:
	get: return get_member(&"bounds") as RosMsg
	set(v): set_member(&"bounds", v)

