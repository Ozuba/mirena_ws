extends RosMsg
class_name RosRosGzInterfacesLogicalCameraImageModel

func _init():
	init("ros_gz_interfaces/msg/LogicalCameraImageModel")

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var pose : RosGeometryMsgsPose:
	get: return get_member(&"pose") as RosMsg
	set(v): set_member(&"pose", v)

