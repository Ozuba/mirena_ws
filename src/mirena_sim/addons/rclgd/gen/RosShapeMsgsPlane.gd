extends RosMsg
class_name RosShapeMsgsPlane

const ROS_TYPE_NAME = "shape_msgs/msg/Plane"

func _init():
	init(ROS_TYPE_NAME)

var coef : PackedFloat64Array:
	get: return get_member(&"coef")
	set(v): set_member(&"coef", v)

