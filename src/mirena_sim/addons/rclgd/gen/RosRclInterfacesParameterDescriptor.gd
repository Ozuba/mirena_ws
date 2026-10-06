extends RosMsg
class_name RosRclInterfacesParameterDescriptor

const ROS_TYPE_NAME = "rcl_interfaces/msg/ParameterDescriptor"

func _init():
	init(ROS_TYPE_NAME)

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var type : int:
	get: return get_member(&"type")
	set(v): set_member(&"type", v)

var description : String:
	get: return get_member(&"description")
	set(v): set_member(&"description", v)

var additional_constraints : String:
	get: return get_member(&"additional_constraints")
	set(v): set_member(&"additional_constraints", v)

var read_only : bool:
	get: return get_member(&"read_only")
	set(v): set_member(&"read_only", v)

var dynamic_typing : bool:
	get: return get_member(&"dynamic_typing")
	set(v): set_member(&"dynamic_typing", v)

