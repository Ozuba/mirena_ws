extends RosMsg
class_name RosStdMsgsUInt64MultiArray

const ROS_TYPE_NAME = "std_msgs/msg/UInt64MultiArray"

func _init():
	init(ROS_TYPE_NAME)

var layout : RosStdMsgsMultiArrayLayout:
	get: return get_member(&"layout") as RosMsg
	set(v): set_member(&"layout", v)

var data : Array:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

