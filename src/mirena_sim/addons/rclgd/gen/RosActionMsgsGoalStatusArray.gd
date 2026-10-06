extends RosMsg
class_name RosActionMsgsGoalStatusArray

const ROS_TYPE_NAME = "action_msgs/msg/GoalStatusArray"

func _init():
	init(ROS_TYPE_NAME)

var status_list : Array:
	get: return get_member(&"status_list")
	set(v): set_member(&"status_list", v)

