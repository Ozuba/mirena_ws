extends RosMsg
class_name RosRosbag2InterfacesReadSplitEvent

const ROS_TYPE_NAME = "rosbag2_interfaces/msg/ReadSplitEvent"

func _init():
	init(ROS_TYPE_NAME)

var closed_file : String:
	get: return get_member(&"closed_file")
	set(v): set_member(&"closed_file", v)

var opened_file : String:
	get: return get_member(&"opened_file")
	set(v): set_member(&"opened_file", v)

var node_name : String:
	get: return get_member(&"node_name")
	set(v): set_member(&"node_name", v)

