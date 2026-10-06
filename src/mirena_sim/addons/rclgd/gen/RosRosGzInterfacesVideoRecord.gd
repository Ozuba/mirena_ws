extends RosMsg
class_name RosRosGzInterfacesVideoRecord

func _init():
	init("ros_gz_interfaces/msg/VideoRecord")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var start : bool:
	get: return get_member(&"start")
	set(v): set_member(&"start", v)

var stop : bool:
	get: return get_member(&"stop")
	set(v): set_member(&"stop", v)

var format : String:
	get: return get_member(&"format")
	set(v): set_member(&"format", v)

var save_filename : String:
	get: return get_member(&"save_filename")
	set(v): set_member(&"save_filename", v)

