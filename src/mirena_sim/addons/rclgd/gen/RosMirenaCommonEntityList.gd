extends RosMsg
class_name RosMirenaCommonEntityList

const ROS_TYPE_NAME = "mirena_common/msg/EntityList"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var entities : Array:
	get: return get_member(&"entities")
	set(v): set_member(&"entities", v)

