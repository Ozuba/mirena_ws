extends RosMsg
class_name RosActionMsgsGoalStatus

const ROS_TYPE_NAME = "action_msgs/msg/GoalStatus"

func _init():
	init(ROS_TYPE_NAME)

var goal_info : RosActionMsgsGoalInfo:
	get: return get_member(&"goal_info") as RosMsg
	set(v): set_member(&"goal_info", v)

var status : int:
	get: return get_member(&"status")
	set(v): set_member(&"status", v)

