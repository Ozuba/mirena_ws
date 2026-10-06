extends RosMsg
class_name RosRosbag2TestMsgdefsComplexIdl

func _init():
	init("rosbag2_test_msgdefs/msg/ComplexIdl")

var a : RosRosbag2TestMsgdefsBasicIdl:
	get: return get_member(&"a") as RosMsg
	set(v): set_member(&"a", v)

