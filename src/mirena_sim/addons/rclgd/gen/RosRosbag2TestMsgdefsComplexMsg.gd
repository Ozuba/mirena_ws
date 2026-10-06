extends RosMsg
class_name RosRosbag2TestMsgdefsComplexMsg

func _init():
	init("rosbag2_test_msgdefs/msg/ComplexMsg")

var b : RosRosbag2TestMsgdefsBasicMsg:
	get: return get_member(&"b") as RosMsg
	set(v): set_member(&"b", v)

