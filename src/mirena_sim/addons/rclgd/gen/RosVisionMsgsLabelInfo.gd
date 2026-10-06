extends RosMsg
class_name RosVisionMsgsLabelInfo

func _init():
	init("vision_msgs/msg/LabelInfo")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var class_map : Array:
	get: return get_member(&"class_map")
	set(v): set_member(&"class_map", v)

var threshold : float:
	get: return get_member(&"threshold")
	set(v): set_member(&"threshold", v)

