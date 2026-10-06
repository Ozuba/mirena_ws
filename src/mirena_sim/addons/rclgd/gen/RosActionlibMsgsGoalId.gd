extends RosMsg
class_name RosActionlibMsgsGoalId

const ROS_TYPE_NAME = "actionlib_msgs/msg/GoalID"

func _init():
	init(ROS_TYPE_NAME)

var stamp : RosBuiltinInterfacesTime:
	get: return get_member(&"stamp") as RosMsg
	set(v): set_member(&"stamp", v)

var id : String:
	get: return get_member(&"id")
	set(v): set_member(&"id", v)

