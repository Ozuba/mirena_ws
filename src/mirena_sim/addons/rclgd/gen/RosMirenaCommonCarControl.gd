extends RosMsg
class_name RosMirenaCommonCarControl

const ROS_TYPE_NAME = "mirena_common/msg/CarControl"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var gas : float:
	get: return get_member(&"gas")
	set(v): set_member(&"gas", v)

var steer_angle : float:
	get: return get_member(&"steer_angle")
	set(v): set_member(&"steer_angle", v)

