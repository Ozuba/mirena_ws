extends RosMsg
class_name RosRosGzInterfacesSensorNoise

func _init():
	init("ros_gz_interfaces/msg/SensorNoise")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var type : int:
	get: return get_member(&"type")
	set(v): set_member(&"type", v)

var mean : float:
	get: return get_member(&"mean")
	set(v): set_member(&"mean", v)

var stddev : float:
	get: return get_member(&"stddev")
	set(v): set_member(&"stddev", v)

var bias_mean : float:
	get: return get_member(&"bias_mean")
	set(v): set_member(&"bias_mean", v)

var bias_stddev : float:
	get: return get_member(&"bias_stddev")
	set(v): set_member(&"bias_stddev", v)

var precision : float:
	get: return get_member(&"precision")
	set(v): set_member(&"precision", v)

var dynamic_bias_stddev : float:
	get: return get_member(&"dynamic_bias_stddev")
	set(v): set_member(&"dynamic_bias_stddev", v)

var dynamic_bias_correlation_time : float:
	get: return get_member(&"dynamic_bias_correlation_time")
	set(v): set_member(&"dynamic_bias_correlation_time", v)

