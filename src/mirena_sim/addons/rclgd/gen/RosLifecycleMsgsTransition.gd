extends RosMsg
class_name RosLifecycleMsgsTransition

const ROS_TYPE_NAME = "lifecycle_msgs/msg/Transition"

func _init():
	init(ROS_TYPE_NAME)

var id : int:
	get: return get_member(&"id")
	set(v): set_member(&"id", v)

var label : String:
	get: return get_member(&"label")
	set(v): set_member(&"label", v)

