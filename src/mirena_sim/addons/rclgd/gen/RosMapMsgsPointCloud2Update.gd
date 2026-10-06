extends RosMsg
class_name RosMapMsgsPointCloud2Update

const ROS_TYPE_NAME = "map_msgs/msg/PointCloud2Update"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var type : int:
	get: return get_member(&"type")
	set(v): set_member(&"type", v)

var points : RosSensorMsgsPointCloud2:
	get: return get_member(&"points") as RosMsg
	set(v): set_member(&"points", v)

