extends RosMsg
class_name RosVisionMsgsBoundingBox2d

func _init():
	init("vision_msgs/msg/BoundingBox2D")

var center : RosVisionMsgsPose2d:
	get: return get_member(&"center") as RosMsg
	set(v): set_member(&"center", v)

var size_x : float:
	get: return get_member(&"size_x")
	set(v): set_member(&"size_x", v)

var size_y : float:
	get: return get_member(&"size_y")
	set(v): set_member(&"size_y", v)

