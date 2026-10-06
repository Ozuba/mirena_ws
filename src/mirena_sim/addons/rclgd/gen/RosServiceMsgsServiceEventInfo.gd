extends RosMsg
class_name RosServiceMsgsServiceEventInfo

const ROS_TYPE_NAME = "service_msgs/msg/ServiceEventInfo"

func _init():
	init(ROS_TYPE_NAME)

var event_type : int:
	get: return get_member(&"event_type")
	set(v): set_member(&"event_type", v)

var stamp : RosBuiltinInterfacesTime:
	get: return get_member(&"stamp") as RosMsg
	set(v): set_member(&"stamp", v)

var client_gid : PackedByteArray:
	get: return get_member(&"client_gid")
	set(v): set_member(&"client_gid", v)

var sequence_number : int:
	get: return get_member(&"sequence_number")
	set(v): set_member(&"sequence_number", v)

