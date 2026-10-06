extends RosMsg
class_name RosRosBabelFishTestMsgsTestSubArray

func _init():
	init("ros_babel_fish_test_msgs/msg/TestSubArray")

var ints : Array:
	get: return get_member(&"ints")
	set(v): set_member(&"ints", v)

var strings : PackedStringArray:
	get: return get_member(&"strings")
	set(v): set_member(&"strings", v)

