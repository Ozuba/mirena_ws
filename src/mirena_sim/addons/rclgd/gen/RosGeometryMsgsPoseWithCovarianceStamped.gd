extends RosMsg
class_name RosGeometryMsgsPoseWithCovarianceStamped

const ROS_TYPE_NAME = "geometry_msgs/msg/PoseWithCovarianceStamped"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var pose : RosGeometryMsgsPoseWithCovariance:
	get: return get_member(&"pose") as RosMsg
	set(v): set_member(&"pose", v)

