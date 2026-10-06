extends RosMsg
class_name RosMapMsgsOccupancyGridUpdate

const ROS_TYPE_NAME = "map_msgs/msg/OccupancyGridUpdate"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var x : int:
	get: return get_member(&"x")
	set(v): set_member(&"x", v)

var y : int:
	get: return get_member(&"y")
	set(v): set_member(&"y", v)

var width : int:
	get: return get_member(&"width")
	set(v): set_member(&"width", v)

var height : int:
	get: return get_member(&"height")
	set(v): set_member(&"height", v)

var data : Array:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

