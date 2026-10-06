extends RosMsg
class_name RosMirenaCommonDebugEntity

const ROS_TYPE_NAME = "mirena_common/msg/DebugEntity"

func _init():
	init(ROS_TYPE_NAME)

var ent : RosMirenaCommonEntity:
	get: return get_member(&"ent") as RosMsg
	set(v): set_member(&"ent", v)

var debug_id : int:
	get: return get_member(&"debug_id")
	set(v): set_member(&"debug_id", v)

var debug_real_position : RosGeometryMsgsPoint:
	get: return get_member(&"debug_real_position") as RosMsg
	set(v): set_member(&"debug_real_position", v)

