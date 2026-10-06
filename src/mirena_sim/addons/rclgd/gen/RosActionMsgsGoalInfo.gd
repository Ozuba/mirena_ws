extends RosMsg
class_name RosActionMsgsGoalInfo

const ROS_TYPE_NAME = "action_msgs/msg/GoalInfo"

func _init():
	init(ROS_TYPE_NAME)

var goal_id : RosUniqueIdentifierMsgsUuid:
	get: return get_member(&"goal_id") as RosMsg
	set(v): set_member(&"goal_id", v)

var stamp : RosBuiltinInterfacesTime:
	get: return get_member(&"stamp") as RosMsg
	set(v): set_member(&"stamp", v)

