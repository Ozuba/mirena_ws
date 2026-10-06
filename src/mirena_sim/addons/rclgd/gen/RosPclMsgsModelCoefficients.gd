extends RosMsg
class_name RosPclMsgsModelCoefficients

const ROS_TYPE_NAME = "pcl_msgs/msg/ModelCoefficients"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var values : PackedFloat32Array:
	get: return get_member(&"values")
	set(v): set_member(&"values", v)

