extends RosMsg
class_name RosRclInterfacesFloatingPointRange

const ROS_TYPE_NAME = "rcl_interfaces/msg/FloatingPointRange"

func _init():
	init(ROS_TYPE_NAME)

var from_value : float:
	get: return get_member(&"from_value")
	set(v): set_member(&"from_value", v)

var to_value : float:
	get: return get_member(&"to_value")
	set(v): set_member(&"to_value", v)

var step : float:
	get: return get_member(&"step")
	set(v): set_member(&"step", v)

