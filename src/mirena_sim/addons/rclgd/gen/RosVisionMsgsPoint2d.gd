extends RosMsg
class_name RosVisionMsgsPoint2d

func _init():
	init("vision_msgs/msg/Point2D")

var x : float:
	get: return get_member(&"x")
	set(v): set_member(&"x", v)

var y : float:
	get: return get_member(&"y")
	set(v): set_member(&"y", v)

