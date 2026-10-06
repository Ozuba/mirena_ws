extends RosMsg
class_name RosRosGzInterfacesLogPlaybackStatistics

func _init():
	init("ros_gz_interfaces/msg/LogPlaybackStatistics")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var start_time : RosBuiltinInterfacesTime:
	get: return get_member(&"start_time") as RosMsg
	set(v): set_member(&"start_time", v)

var end_time : RosBuiltinInterfacesTime:
	get: return get_member(&"end_time") as RosMsg
	set(v): set_member(&"end_time", v)

