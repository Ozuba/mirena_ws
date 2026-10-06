extends RosMsg
class_name RosVisionMsgsObjectHypothesis

func _init():
	init("vision_msgs/msg/ObjectHypothesis")

var class_id : String:
	get: return get_member(&"class_id")
	set(v): set_member(&"class_id", v)

var score : float:
	get: return get_member(&"score")
	set(v): set_member(&"score", v)

