extends RosMsg
class_name RosGeometryMsgsTwist

const ROS_TYPE_NAME = "geometry_msgs/msg/Twist"

func _init():
	init(ROS_TYPE_NAME)

var linear : RosGeometryMsgsVector3:
	get: return get_member(&"linear") as RosMsg
	set(v): set_member(&"linear", v)

var angular : RosGeometryMsgsVector3:
	get: return get_member(&"angular") as RosMsg
	set(v): set_member(&"angular", v)

