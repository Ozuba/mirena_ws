extends RosMsg
class_name RosTypeDescriptionInterfacesIndividualTypeDescription

const ROS_TYPE_NAME = "type_description_interfaces/msg/IndividualTypeDescription"

func _init():
	init(ROS_TYPE_NAME)

var type_name : String:
	get: return get_member(&"type_name")
	set(v): set_member(&"type_name", v)

var fields : Array:
	get: return get_member(&"fields")
	set(v): set_member(&"fields", v)

