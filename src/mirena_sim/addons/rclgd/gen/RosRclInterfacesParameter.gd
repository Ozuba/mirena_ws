extends RosMsg
class_name RosRclInterfacesParameter

const ROS_TYPE_NAME = "rcl_interfaces/msg/Parameter"

func _init():
	init(ROS_TYPE_NAME)

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var value : RosRclInterfacesParameterValue:
	get: return get_member(&"value") as RosMsg
	set(v): set_member(&"value", v)

