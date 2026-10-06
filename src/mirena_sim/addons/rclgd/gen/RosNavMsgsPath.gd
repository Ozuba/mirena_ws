extends RosMsg
class_name RosNavMsgsPath

const ROS_TYPE_NAME = "nav_msgs/msg/Path"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var poses : Array:
	get: return get_member(&"poses")
	set(v): set_member(&"poses", v)

