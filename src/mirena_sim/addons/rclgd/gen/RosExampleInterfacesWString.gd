extends RosMsg
class_name RosExampleInterfacesWString

const ROS_TYPE_NAME = "example_interfaces/msg/WString"

func _init():
	init(ROS_TYPE_NAME)

var data : Nil:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

