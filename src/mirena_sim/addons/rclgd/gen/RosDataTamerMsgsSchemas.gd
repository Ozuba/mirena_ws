extends RosMsg
class_name RosDataTamerMsgsSchemas

const ROS_TYPE_NAME = "data_tamer_msgs/msg/Schemas"

func _init():
	init(ROS_TYPE_NAME)

var schemas : Array:
	get: return get_member(&"schemas")
	set(v): set_member(&"schemas", v)

