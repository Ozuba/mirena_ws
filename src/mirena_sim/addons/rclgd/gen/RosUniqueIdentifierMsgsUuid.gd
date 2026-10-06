extends RosMsg
class_name RosUniqueIdentifierMsgsUuid

const ROS_TYPE_NAME = "unique_identifier_msgs/msg/UUID"

func _init():
	init(ROS_TYPE_NAME)

var uuid : PackedByteArray:
	get: return get_member(&"uuid")
	set(v): set_member(&"uuid", v)

