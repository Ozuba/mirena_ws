extends RosMsg
class_name RosMirenaCommonHeartbeat

const ROS_TYPE_NAME = "mirena_common/msg/Heartbeat"

func _init():
	init(ROS_TYPE_NAME)

var timestamp : RosBuiltinInterfacesTime:
	get: return get_member(&"timestamp") as RosMsg
	set(v): set_member(&"timestamp", v)

var node_name : String:
	get: return get_member(&"node_name")
	set(v): set_member(&"node_name", v)

var report : String:
	get: return get_member(&"report")
	set(v): set_member(&"report", v)

