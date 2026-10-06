extends RosMsg
class_name RosRosgraphMsgsClock

const ROS_TYPE_NAME = "rosgraph_msgs/msg/Clock"

func _init():
	init(ROS_TYPE_NAME)

var clock : RosBuiltinInterfacesTime:
	get: return get_member(&"clock") as RosMsg
	set(v): set_member(&"clock", v)

