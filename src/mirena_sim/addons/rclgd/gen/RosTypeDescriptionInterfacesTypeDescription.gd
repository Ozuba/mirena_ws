extends RosMsg
class_name RosTypeDescriptionInterfacesTypeDescription

const ROS_TYPE_NAME = "type_description_interfaces/msg/TypeDescription"

func _init():
	init(ROS_TYPE_NAME)

var type_description : RosTypeDescriptionInterfacesIndividualTypeDescription:
	get: return get_member(&"type_description") as RosMsg
	set(v): set_member(&"type_description", v)

var referenced_type_descriptions : Array:
	get: return get_member(&"referenced_type_descriptions")
	set(v): set_member(&"referenced_type_descriptions", v)

