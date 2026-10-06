extends RosMsg
class_name RosDataTamerMsgsSchema

const ROS_TYPE_NAME = "data_tamer_msgs/msg/Schema"

func _init():
	init(ROS_TYPE_NAME)

var hash : int:
	get: return get_member(&"hash")
	set(v): set_member(&"hash", v)

var channel_name : String:
	get: return get_member(&"channel_name")
	set(v): set_member(&"channel_name", v)

var schema_text : String:
	get: return get_member(&"schema_text")
	set(v): set_member(&"schema_text", v)

