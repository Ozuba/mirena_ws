extends RosMsg
class_name RosTypeDescriptionInterfacesFieldType

const ROS_TYPE_NAME = "type_description_interfaces/msg/FieldType"

func _init():
	init(ROS_TYPE_NAME)

var type_id : int:
	get: return get_member(&"type_id")
	set(v): set_member(&"type_id", v)

var capacity : int:
	get: return get_member(&"capacity")
	set(v): set_member(&"capacity", v)

var string_capacity : int:
	get: return get_member(&"string_capacity")
	set(v): set_member(&"string_capacity", v)

var nested_type_name : String:
	get: return get_member(&"nested_type_name")
	set(v): set_member(&"nested_type_name", v)

