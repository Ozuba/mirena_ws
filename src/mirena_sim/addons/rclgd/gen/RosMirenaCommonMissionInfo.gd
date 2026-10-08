extends RosMsg
class_name RosMirenaCommonMissionInfo

const ROS_TYPE_NAME = "mirena_common/msg/MissionInfo"

func _init():
	init(ROS_TYPE_NAME)

var status : int:
	get: return get_member(&"status")
	set(v): set_member(&"status", v)

var cones_count_actual : int:
	get: return get_member(&"cones_count_actual")
	set(v): set_member(&"cones_count_actual", v)

var cones_count_total : int:
	get: return get_member(&"cones_count_total")
	set(v): set_member(&"cones_count_total", v)

var lap_counter : int:
	get: return get_member(&"lap_counter")
	set(v): set_member(&"lap_counter", v)

