extends RosMsg
class_name RosPclMsgsPolygonMesh

const ROS_TYPE_NAME = "pcl_msgs/msg/PolygonMesh"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var cloud : RosSensorMsgsPointCloud2:
	get: return get_member(&"cloud") as RosMsg
	set(v): set_member(&"cloud", v)

var polygons : Array:
	get: return get_member(&"polygons")
	set(v): set_member(&"polygons", v)

