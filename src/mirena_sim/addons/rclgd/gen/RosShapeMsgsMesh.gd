extends RosMsg
class_name RosShapeMsgsMesh

const ROS_TYPE_NAME = "shape_msgs/msg/Mesh"

func _init():
	init(ROS_TYPE_NAME)

var triangles : Array:
	get: return get_member(&"triangles")
	set(v): set_member(&"triangles", v)

var vertices : Array:
	get: return get_member(&"vertices")
	set(v): set_member(&"vertices", v)

