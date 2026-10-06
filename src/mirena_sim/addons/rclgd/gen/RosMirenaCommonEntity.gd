extends RosMsg
class_name RosMirenaCommonEntity

const ROS_TYPE_NAME = "mirena_common/msg/Entity"

func _init():
	init(ROS_TYPE_NAME)

var position : RosGeometryMsgsPoint:
	get: return get_member(&"position") as RosMsg
	set(v): set_member(&"position", v)

var type : String:
	get: return get_member(&"type")
	set(v): set_member(&"type", v)

var confidence : float:
	get: return get_member(&"confidence")
	set(v): set_member(&"confidence", v)

