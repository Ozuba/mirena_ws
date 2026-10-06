extends RosMsg
class_name RosRclInterfacesLog

const ROS_TYPE_NAME = "rcl_interfaces/msg/Log"

func _init():
	init(ROS_TYPE_NAME)

var stamp : RosBuiltinInterfacesTime:
	get: return get_member(&"stamp") as RosMsg
	set(v): set_member(&"stamp", v)

var level : int:
	get: return get_member(&"level")
	set(v): set_member(&"level", v)

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var msg : String:
	get: return get_member(&"msg")
	set(v): set_member(&"msg", v)

var file : String:
	get: return get_member(&"file")
	set(v): set_member(&"file", v)

var function : String:
	get: return get_member(&"function")
	set(v): set_member(&"function", v)

var line : int:
	get: return get_member(&"line")
	set(v): set_member(&"line", v)

