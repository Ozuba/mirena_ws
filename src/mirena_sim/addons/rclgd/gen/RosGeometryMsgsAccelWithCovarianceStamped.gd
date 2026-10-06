extends RosMsg
class_name RosGeometryMsgsAccelWithCovarianceStamped

const ROS_TYPE_NAME = "geometry_msgs/msg/AccelWithCovarianceStamped"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var accel : RosGeometryMsgsAccelWithCovariance:
	get: return get_member(&"accel") as RosMsg
	set(v): set_member(&"accel", v)

