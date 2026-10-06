extends RosMsg
class_name RosDataTamerMsgsSnapshot

const ROS_TYPE_NAME = "data_tamer_msgs/msg/Snapshot"

func _init():
	init(ROS_TYPE_NAME)

var timestamp_nsec : int:
	get: return get_member(&"timestamp_nsec")
	set(v): set_member(&"timestamp_nsec", v)

var schema_hash : int:
	get: return get_member(&"schema_hash")
	set(v): set_member(&"schema_hash", v)

var active_mask : PackedByteArray:
	get: return get_member(&"active_mask")
	set(v): set_member(&"active_mask", v)

var payload : PackedByteArray:
	get: return get_member(&"payload")
	set(v): set_member(&"payload", v)

