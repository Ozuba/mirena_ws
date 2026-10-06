extends RosMsg
class_name RosRclInterfacesIntegerRange

const ROS_TYPE_NAME = "rcl_interfaces/msg/IntegerRange"

func _init():
	init(ROS_TYPE_NAME)

var from_value : int:
	get: return get_member(&"from_value")
	set(v): set_member(&"from_value", v)

var to_value : int:
	get: return get_member(&"to_value")
	set(v): set_member(&"to_value", v)

var step : int:
	get: return get_member(&"step")
	set(v): set_member(&"step", v)

