extends RosMsg
class_name RosStdMsgsInt64MultiArray

const ROS_TYPE_NAME = "std_msgs/msg/Int64MultiArray"

func _init():
	init(ROS_TYPE_NAME)

var layout : RosStdMsgsMultiArrayLayout:
	get: return get_member(&"layout") as RosMsg
	set(v): set_member(&"layout", v)

var data : Array:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

