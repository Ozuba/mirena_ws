extends RosMsg
class_name RosVisionMsgsDetection2d

func _init():
	init("vision_msgs/msg/Detection2D")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var results : Array:
	get: return get_member(&"results")
	set(v): set_member(&"results", v)

var bbox : RosVisionMsgsBoundingBox2d:
	get: return get_member(&"bbox") as RosMsg
	set(v): set_member(&"bbox", v)

var id : String:
	get: return get_member(&"id")
	set(v): set_member(&"id", v)

