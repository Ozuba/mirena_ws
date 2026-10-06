extends RosMsg
class_name RosVisionMsgsPose2d

func _init():
	init("vision_msgs/msg/Pose2D")

var position : RosVisionMsgsPoint2d:
	get: return get_member(&"position") as RosMsg
	set(v): set_member(&"position", v)

var theta : float:
	get: return get_member(&"theta")
	set(v): set_member(&"theta", v)

