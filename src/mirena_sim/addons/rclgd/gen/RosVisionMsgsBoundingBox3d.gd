extends RosMsg
class_name RosVisionMsgsBoundingBox3d

func _init():
	init("vision_msgs/msg/BoundingBox3D")

var center : RosGeometryMsgsPose:
	get: return get_member(&"center") as RosMsg
	set(v): set_member(&"center", v)

var size : RosGeometryMsgsVector3:
	get: return get_member(&"size") as RosMsg
	set(v): set_member(&"size", v)

