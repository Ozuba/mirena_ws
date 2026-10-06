extends RosMsg
class_name RosPlotjugglerMsgsDataPoints

const ROS_TYPE_NAME = "plotjuggler_msgs/msg/DataPoints"

func _init():
	init(ROS_TYPE_NAME)

var dictionary_uuid : int:
	get: return get_member(&"dictionary_uuid")
	set(v): set_member(&"dictionary_uuid", v)

var samples : Array:
	get: return get_member(&"samples")
	set(v): set_member(&"samples", v)

