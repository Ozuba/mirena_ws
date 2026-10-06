extends RosMsg
class_name RosDiagnosticMsgsDiagnosticStatus

const ROS_TYPE_NAME = "diagnostic_msgs/msg/DiagnosticStatus"

func _init():
	init(ROS_TYPE_NAME)

var level : int:
	get: return get_member(&"level")
	set(v): set_member(&"level", v)

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var message : String:
	get: return get_member(&"message")
	set(v): set_member(&"message", v)

var hardware_id : String:
	get: return get_member(&"hardware_id")
	set(v): set_member(&"hardware_id", v)

var values : Array:
	get: return get_member(&"values")
	set(v): set_member(&"values", v)

