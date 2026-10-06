extends RosMsg
class_name RosVisionMsgsVisionClass

func _init():
	init("vision_msgs/msg/VisionClass")

var class_id : int:
	get: return get_member(&"class_id")
	set(v): set_member(&"class_id", v)

var class_name : String:
	get: return get_member(&"class_name")
	set(v): set_member(&"class_name", v)

