extends RosMsg
class_name RosTestMsgsBuiltins

func _init():
	init("test_msgs/msg/Builtins")

var duration_value : RosBuiltinInterfacesDuration:
	get: return get_member(&"duration_value") as RosMsg
	set(v): set_member(&"duration_value", v)

var time_value : RosBuiltinInterfacesTime:
	get: return get_member(&"time_value") as RosMsg
	set(v): set_member(&"time_value", v)

