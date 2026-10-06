extends RosMsg
class_name RosRmwDdsCommonGid

const ROS_TYPE_NAME = "rmw_dds_common/msg/Gid"

func _init():
	init(ROS_TYPE_NAME)

var data : PackedByteArray:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

