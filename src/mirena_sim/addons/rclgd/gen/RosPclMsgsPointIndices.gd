extends RosMsg
class_name RosPclMsgsPointIndices

const ROS_TYPE_NAME = "pcl_msgs/msg/PointIndices"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var indices : Array:
	get: return get_member(&"indices")
	set(v): set_member(&"indices", v)

