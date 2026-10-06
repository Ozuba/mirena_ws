extends RosMsg
class_name RosGeometryMsgsInertiaStamped

const ROS_TYPE_NAME = "geometry_msgs/msg/InertiaStamped"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var inertia : RosGeometryMsgsInertia:
	get: return get_member(&"inertia") as RosMsg
	set(v): set_member(&"inertia", v)

