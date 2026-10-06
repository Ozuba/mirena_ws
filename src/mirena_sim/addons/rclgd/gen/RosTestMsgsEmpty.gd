extends RosMsg
class_name RosTestMsgsEmpty

func _init():
	init("test_msgs/msg/Empty")

var structure_needs_at_least_one_member : int:
	get: return get_member(&"structure_needs_at_least_one_member")
	set(v): set_member(&"structure_needs_at_least_one_member", v)

