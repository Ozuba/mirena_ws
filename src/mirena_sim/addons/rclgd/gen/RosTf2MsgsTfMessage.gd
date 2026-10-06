extends RosMsg
class_name RosTf2MsgsTfMessage

const ROS_TYPE_NAME = "tf2_msgs/msg/TFMessage"

func _init():
	init(ROS_TYPE_NAME)

var transforms : Array:
	get: return get_member(&"transforms")
	set(v): set_member(&"transforms", v)

