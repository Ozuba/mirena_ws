extends RosMsg
class_name RosMirenaCommonAsInfo

const ROS_TYPE_NAME = "mirena_common/msg/AsInfo"

func _init():
	init(ROS_TYPE_NAME)

var status : int:
	get: return get_member(&"status")
	set(v): set_member(&"status", v)

var mission : int:
	get: return get_member(&"mission")
	set(v): set_member(&"mission", v)

