extends RosMsg
class_name RosTypeDescriptionInterfacesKeyValue

const ROS_TYPE_NAME = "type_description_interfaces/msg/KeyValue"

func _init():
	init(ROS_TYPE_NAME)

var key : String:
	get: return get_member(&"key")
	set(v): set_member(&"key", v)

var value : String:
	get: return get_member(&"value")
	set(v): set_member(&"value", v)

