extends RosMsg
class_name RosTestMsgsNested

func _init():
	init("test_msgs/msg/Nested")

var basic_types_value : RosTestMsgsBasicTypes:
	get: return get_member(&"basic_types_value") as RosMsg
	set(v): set_member(&"basic_types_value", v)

