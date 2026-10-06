extends RosMsg
class_name RosMirenaCommonWheelSpeeds

const ROS_TYPE_NAME = "mirena_common/msg/WheelSpeeds"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var rl : float:
	get: return get_member(&"rl")
	set(v): set_member(&"rl", v)

var rr : float:
	get: return get_member(&"rr")
	set(v): set_member(&"rr", v)

