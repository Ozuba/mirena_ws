extends RosMsg
class_name RosTrajectoryMsgsJointTrajectoryPoint

const ROS_TYPE_NAME = "trajectory_msgs/msg/JointTrajectoryPoint"

func _init():
	init(ROS_TYPE_NAME)

var positions : PackedFloat64Array:
	get: return get_member(&"positions")
	set(v): set_member(&"positions", v)

var velocities : PackedFloat64Array:
	get: return get_member(&"velocities")
	set(v): set_member(&"velocities", v)

var accelerations : PackedFloat64Array:
	get: return get_member(&"accelerations")
	set(v): set_member(&"accelerations", v)

var effort : PackedFloat64Array:
	get: return get_member(&"effort")
	set(v): set_member(&"effort", v)

var time_from_start : RosBuiltinInterfacesDuration:
	get: return get_member(&"time_from_start") as RosMsg
	set(v): set_member(&"time_from_start", v)

