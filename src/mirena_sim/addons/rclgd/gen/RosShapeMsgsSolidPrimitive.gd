extends RosMsg
class_name RosShapeMsgsSolidPrimitive

const ROS_TYPE_NAME = "shape_msgs/msg/SolidPrimitive"

func _init():
	init(ROS_TYPE_NAME)

var type : int:
	get: return get_member(&"type")
	set(v): set_member(&"type", v)

var dimensions : PackedFloat64Array:
	get: return get_member(&"dimensions")
	set(v): set_member(&"dimensions", v)

var polygon : RosGeometryMsgsPolygon:
	get: return get_member(&"polygon") as RosMsg
	set(v): set_member(&"polygon", v)

