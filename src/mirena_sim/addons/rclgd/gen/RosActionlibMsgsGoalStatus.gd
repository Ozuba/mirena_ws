extends RosMsg
class_name RosActionlibMsgsGoalStatus

const ROS_TYPE_NAME = "actionlib_msgs/msg/GoalStatus"

func _init():
	init(ROS_TYPE_NAME)

var goal_id : RosActionlibMsgsGoalId:
	get: return get_member(&"goal_id") as RosMsg
	set(v): set_member(&"goal_id", v)

var status : int:
	get: return get_member(&"status")
	set(v): set_member(&"status", v)

var text : String:
	get: return get_member(&"text")
	set(v): set_member(&"text", v)

