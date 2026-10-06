extends RosMsg
class_name RosRosbag2TestMsgdefsBasicMsg

func _init():
	init("rosbag2_test_msgdefs/msg/BasicMsg")

var c : float:
	get: return get_member(&"c")
	set(v): set_member(&"c", v)

