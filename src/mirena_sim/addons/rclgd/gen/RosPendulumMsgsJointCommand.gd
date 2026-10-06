extends RosMsg
class_name RosPendulumMsgsJointCommand

const ROS_TYPE_NAME = "pendulum_msgs/msg/JointCommand"

func _init():
	init(ROS_TYPE_NAME)

var position : float:
	get: return get_member(&"position")
	set(v): set_member(&"position", v)

