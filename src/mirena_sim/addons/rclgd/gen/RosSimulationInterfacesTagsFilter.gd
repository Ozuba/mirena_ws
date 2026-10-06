extends RosMsg
class_name RosSimulationInterfacesTagsFilter

func _init():
	init("simulation_interfaces/msg/TagsFilter")

var tags : PackedStringArray:
	get: return get_member(&"tags")
	set(v): set_member(&"tags", v)

var filter_mode : int:
	get: return get_member(&"filter_mode")
	set(v): set_member(&"filter_mode", v)

