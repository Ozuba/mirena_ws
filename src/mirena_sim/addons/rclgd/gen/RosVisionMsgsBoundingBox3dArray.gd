extends RosMsg
class_name RosVisionMsgsBoundingBox3dArray

func _init():
	init("vision_msgs/msg/BoundingBox3DArray")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var boxes : Array:
	get: return get_member(&"boxes")
	set(v): set_member(&"boxes", v)

