extends RosMsg
class_name RosVisionMsgsClassification

func _init():
	init("vision_msgs/msg/Classification")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var results : Array:
	get: return get_member(&"results")
	set(v): set_member(&"results", v)

