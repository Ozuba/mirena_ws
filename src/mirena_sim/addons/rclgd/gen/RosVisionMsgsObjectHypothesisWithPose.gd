extends RosMsg
class_name RosVisionMsgsObjectHypothesisWithPose

func _init():
	init("vision_msgs/msg/ObjectHypothesisWithPose")

var hypothesis : RosVisionMsgsObjectHypothesis:
	get: return get_member(&"hypothesis") as RosMsg
	set(v): set_member(&"hypothesis", v)

var pose : RosGeometryMsgsPoseWithCovariance:
	get: return get_member(&"pose") as RosMsg
	set(v): set_member(&"pose", v)

