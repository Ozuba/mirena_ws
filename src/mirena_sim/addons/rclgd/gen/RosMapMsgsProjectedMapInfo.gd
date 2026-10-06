extends RosMsg
class_name RosMapMsgsProjectedMapInfo

const ROS_TYPE_NAME = "map_msgs/msg/ProjectedMapInfo"

func _init():
	init(ROS_TYPE_NAME)

var frame_id : String:
	get: return get_member(&"frame_id")
	set(v): set_member(&"frame_id", v)

var x : float:
	get: return get_member(&"x")
	set(v): set_member(&"x", v)

var y : float:
	get: return get_member(&"y")
	set(v): set_member(&"y", v)

var width : float:
	get: return get_member(&"width")
	set(v): set_member(&"width", v)

var height : float:
	get: return get_member(&"height")
	set(v): set_member(&"height", v)

var min_z : float:
	get: return get_member(&"min_z")
	set(v): set_member(&"min_z", v)

var max_z : float:
	get: return get_member(&"max_z")
	set(v): set_member(&"max_z", v)

