extends RosMsg
class_name RosPlotjugglerMsgsStatisticsValues

const ROS_TYPE_NAME = "plotjuggler_msgs/msg/StatisticsValues"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var values : PackedFloat64Array:
	get: return get_member(&"values")
	set(v): set_member(&"values", v)

var names_version : int:
	get: return get_member(&"names_version")
	set(v): set_member(&"names_version", v)

