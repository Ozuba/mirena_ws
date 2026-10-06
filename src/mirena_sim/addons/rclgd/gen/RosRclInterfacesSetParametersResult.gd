extends RosMsg
class_name RosRclInterfacesSetParametersResult

const ROS_TYPE_NAME = "rcl_interfaces/msg/SetParametersResult"

func _init():
	init(ROS_TYPE_NAME)

var successful : bool:
	get: return get_member(&"successful")
	set(v): set_member(&"successful", v)

var reason : String:
	get: return get_member(&"reason")
	set(v): set_member(&"reason", v)

