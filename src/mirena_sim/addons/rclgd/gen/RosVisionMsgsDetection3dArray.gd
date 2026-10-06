extends RosMsg
class_name RosVisionMsgsDetection3dArray

func _init():
	init("vision_msgs/msg/Detection3DArray")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var detections : Array:
	get: return get_member(&"detections")
	set(v): set_member(&"detections", v)

