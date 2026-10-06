extends RosMsg
class_name RosStatisticsMsgsStatisticDataPoint

const ROS_TYPE_NAME = "statistics_msgs/msg/StatisticDataPoint"

func _init():
	init(ROS_TYPE_NAME)

var data_type : int:
	get: return get_member(&"data_type")
	set(v): set_member(&"data_type", v)

var data : float:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

