extends RosMsg
class_name RosRosGzInterfacesWorldControl

func _init():
	init("ros_gz_interfaces/msg/WorldControl")

var pause : bool:
	get: return get_member(&"pause")
	set(v): set_member(&"pause", v)

var step : bool:
	get: return get_member(&"step")
	set(v): set_member(&"step", v)

var multi_step : int:
	get: return get_member(&"multi_step")
	set(v): set_member(&"multi_step", v)

var reset : RosRosGzInterfacesWorldReset:
	get: return get_member(&"reset") as RosMsg
	set(v): set_member(&"reset", v)

var seed : int:
	get: return get_member(&"seed")
	set(v): set_member(&"seed", v)

var run_to_sim_time : RosBuiltinInterfacesTime:
	get: return get_member(&"run_to_sim_time") as RosMsg
	set(v): set_member(&"run_to_sim_time", v)

