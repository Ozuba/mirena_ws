extends RosMsg
class_name RosMirenaCommonTrack

const ROS_TYPE_NAME = "mirena_common/msg/Track"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var gates : Array:
	get: return get_member(&"gates")
	set(v): set_member(&"gates", v)

var is_closed : bool:
	get: return get_member(&"is_closed")
	set(v): set_member(&"is_closed", v)

