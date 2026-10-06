extends RosMsg
class_name RosStatisticsMsgsMetricsMessage

const ROS_TYPE_NAME = "statistics_msgs/msg/MetricsMessage"

func _init():
	init(ROS_TYPE_NAME)

var measurement_source_name : String:
	get: return get_member(&"measurement_source_name")
	set(v): set_member(&"measurement_source_name", v)

var metrics_source : String:
	get: return get_member(&"metrics_source")
	set(v): set_member(&"metrics_source", v)

var unit : String:
	get: return get_member(&"unit")
	set(v): set_member(&"unit", v)

var window_start : RosBuiltinInterfacesTime:
	get: return get_member(&"window_start") as RosMsg
	set(v): set_member(&"window_start", v)

var window_stop : RosBuiltinInterfacesTime:
	get: return get_member(&"window_stop") as RosMsg
	set(v): set_member(&"window_stop", v)

var statistics : Array:
	get: return get_member(&"statistics")
	set(v): set_member(&"statistics", v)

