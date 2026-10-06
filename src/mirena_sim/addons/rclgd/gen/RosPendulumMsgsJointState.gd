extends RosMsg
class_name RosPendulumMsgsJointState

const ROS_TYPE_NAME = "pendulum_msgs/msg/JointState"

func _init():
	init(ROS_TYPE_NAME)

var position : float:
	get: return get_member(&"position")
	set(v): set_member(&"position", v)

var velocity : float:
	get: return get_member(&"velocity")
	set(v): set_member(&"velocity", v)

var effort : float:
	get: return get_member(&"effort")
	set(v): set_member(&"effort", v)

