extends RosMsg
class_name RosRclInterfacesParameterType

const ROS_TYPE_NAME = "rcl_interfaces/msg/ParameterType"

func _init():
	init(ROS_TYPE_NAME)

var structure_needs_at_least_one_member : int:
	get: return get_member(&"structure_needs_at_least_one_member")
	set(v): set_member(&"structure_needs_at_least_one_member", v)

