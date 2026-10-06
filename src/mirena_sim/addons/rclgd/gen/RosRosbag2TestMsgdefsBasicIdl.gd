extends RosMsg
class_name RosRosbag2TestMsgdefsBasicIdl

func _init():
	init("rosbag2_test_msgdefs/msg/BasicIdl")

var x : float:
	get: return get_member(&"x")
	set(v): set_member(&"x", v)

