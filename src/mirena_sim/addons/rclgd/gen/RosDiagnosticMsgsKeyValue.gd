extends RosMsg
class_name RosDiagnosticMsgsKeyValue

const ROS_TYPE_NAME = "diagnostic_msgs/msg/KeyValue"

func _init():
	init(ROS_TYPE_NAME)

var key : String:
	get: return get_member(&"key")
	set(v): set_member(&"key", v)

var value : String:
	get: return get_member(&"value")
	set(v): set_member(&"value", v)

