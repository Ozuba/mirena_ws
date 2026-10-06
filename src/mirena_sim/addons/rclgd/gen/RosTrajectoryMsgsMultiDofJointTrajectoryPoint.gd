extends RosMsg
class_name RosTrajectoryMsgsMultiDofJointTrajectoryPoint

const ROS_TYPE_NAME = "trajectory_msgs/msg/MultiDOFJointTrajectoryPoint"

func _init():
	init(ROS_TYPE_NAME)

var transforms : Array:
	get: return get_member(&"transforms")
	set(v): set_member(&"transforms", v)

var velocities : Array:
	get: return get_member(&"velocities")
	set(v): set_member(&"velocities", v)

var accelerations : Array:
	get: return get_member(&"accelerations")
	set(v): set_member(&"accelerations", v)

var time_from_start : RosBuiltinInterfacesDuration:
	get: return get_member(&"time_from_start") as RosMsg
	set(v): set_member(&"time_from_start", v)

