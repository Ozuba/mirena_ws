extends RosMsg
class_name RosRosbag2TestMsgdefsAnotherBasicMsg

func _init():
	init("rosbag2_test_msgdefs/msg/AnotherBasicMsg")

var c : float:
	get: return get_member(&"c")
	set(v): set_member(&"c", v)

