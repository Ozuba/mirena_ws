extends RosMsg
class_name RosRosGzInterfacesLogicalCameraImage

func _init():
	init("ros_gz_interfaces/msg/LogicalCameraImage")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var pose : RosGeometryMsgsPose:
	get: return get_member(&"pose") as RosMsg
	set(v): set_member(&"pose", v)

var model : Array:
	get: return get_member(&"model")
	set(v): set_member(&"model", v)

