extends RosMsg
class_name RosNavMsgsOdometry

const ROS_TYPE_NAME = "nav_msgs/msg/Odometry"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var child_frame_id : String:
	get: return get_member(&"child_frame_id")
	set(v): set_member(&"child_frame_id", v)

var pose : RosGeometryMsgsPoseWithCovariance:
	get: return get_member(&"pose") as RosMsg
	set(v): set_member(&"pose", v)

var twist : RosGeometryMsgsTwistWithCovariance:
	get: return get_member(&"twist") as RosMsg
	set(v): set_member(&"twist", v)

