extends RosMsg
class_name RosRclInterfacesLoggerLevel

const ROS_TYPE_NAME = "rcl_interfaces/msg/LoggerLevel"

func _init():
	init(ROS_TYPE_NAME)

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var level : int:
	get: return get_member(&"level")
	set(v): set_member(&"level", v)

