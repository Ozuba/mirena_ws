extends RosMsg
class_name RosActionlibMsgsGoalStatusArray

const ROS_TYPE_NAME = "actionlib_msgs/msg/GoalStatusArray"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var status_list : Array:
	get: return get_member(&"status_list")
	set(v): set_member(&"status_list", v)

