extends RosMsg
class_name RosRosGzInterfacesStringVec

func _init():
	init("ros_gz_interfaces/msg/StringVec")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var data : PackedStringArray:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

