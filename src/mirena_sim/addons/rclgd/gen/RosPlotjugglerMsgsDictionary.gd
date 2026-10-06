extends RosMsg
class_name RosPlotjugglerMsgsDictionary

const ROS_TYPE_NAME = "plotjuggler_msgs/msg/Dictionary"

func _init():
	init(ROS_TYPE_NAME)

var dictionary_uuid : int:
	get: return get_member(&"dictionary_uuid")
	set(v): set_member(&"dictionary_uuid", v)

var names : PackedStringArray:
	get: return get_member(&"names")
	set(v): set_member(&"names", v)

