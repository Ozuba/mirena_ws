extends RosMsg
class_name RosRosGzInterfacesWorldStatistics

func _init():
	init("ros_gz_interfaces/msg/WorldStatistics")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var sim_time : RosBuiltinInterfacesTime:
	get: return get_member(&"sim_time") as RosMsg
	set(v): set_member(&"sim_time", v)

var pause_time : RosBuiltinInterfacesTime:
	get: return get_member(&"pause_time") as RosMsg
	set(v): set_member(&"pause_time", v)

var real_time : RosBuiltinInterfacesTime:
	get: return get_member(&"real_time") as RosMsg
	set(v): set_member(&"real_time", v)

var paused : bool:
	get: return get_member(&"paused")
	set(v): set_member(&"paused", v)

var iterations : int:
	get: return get_member(&"iterations")
	set(v): set_member(&"iterations", v)

var model_count : int:
	get: return get_member(&"model_count")
	set(v): set_member(&"model_count", v)

var log_playback_statistics : RosRosGzInterfacesLogPlaybackStatistics:
	get: return get_member(&"log_playback_statistics") as RosMsg
	set(v): set_member(&"log_playback_statistics", v)

var real_time_factor : float:
	get: return get_member(&"real_time_factor")
	set(v): set_member(&"real_time_factor", v)

var step_size : RosBuiltinInterfacesTime:
	get: return get_member(&"step_size") as RosMsg
	set(v): set_member(&"step_size", v)

var stepping : bool:
	get: return get_member(&"stepping")
	set(v): set_member(&"stepping", v)

