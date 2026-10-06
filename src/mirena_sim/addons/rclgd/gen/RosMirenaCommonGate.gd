extends RosMsg
class_name RosMirenaCommonGate

const ROS_TYPE_NAME = "mirena_common/msg/Gate"

func _init():
	init(ROS_TYPE_NAME)

var x : float:
	get: return get_member(&"x")
	set(v): set_member(&"x", v)

var y : float:
	get: return get_member(&"y")
	set(v): set_member(&"y", v)

var psi : float:
	get: return get_member(&"psi")
	set(v): set_member(&"psi", v)

