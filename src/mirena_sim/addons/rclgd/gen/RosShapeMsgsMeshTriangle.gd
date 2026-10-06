extends RosMsg
class_name RosShapeMsgsMeshTriangle

const ROS_TYPE_NAME = "shape_msgs/msg/MeshTriangle"

func _init():
	init(ROS_TYPE_NAME)

var vertex_indices : Array:
	get: return get_member(&"vertex_indices")
	set(v): set_member(&"vertex_indices", v)

