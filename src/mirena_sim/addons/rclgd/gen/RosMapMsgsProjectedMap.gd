extends RosMsg
class_name RosMapMsgsProjectedMap

const ROS_TYPE_NAME = "map_msgs/msg/ProjectedMap"

func _init():
	init(ROS_TYPE_NAME)

var map : RosNavMsgsOccupancyGrid:
	get: return get_member(&"map") as RosMsg
	set(v): set_member(&"map", v)

var min_z : float:
	get: return get_member(&"min_z")
	set(v): set_member(&"min_z", v)

var max_z : float:
	get: return get_member(&"max_z")
	set(v): set_member(&"max_z", v)

