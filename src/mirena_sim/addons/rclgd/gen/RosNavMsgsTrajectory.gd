extends RosMsg
class_name RosNavMsgsTrajectory

const ROS_TYPE_NAME = "nav_msgs/msg/Trajectory"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var points : Array:
	get: return get_member(&"points")
	set(v): set_member(&"points", v)

