extends RosMsg
class_name RosRclInterfacesListParametersResult

const ROS_TYPE_NAME = "rcl_interfaces/msg/ListParametersResult"

func _init():
	init(ROS_TYPE_NAME)

var names : PackedStringArray:
	get: return get_member(&"names")
	set(v): set_member(&"names", v)

var prefixes : PackedStringArray:
	get: return get_member(&"prefixes")
	set(v): set_member(&"prefixes", v)

