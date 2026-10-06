extends RosMsg
class_name RosRclInterfacesParameterEventDescriptors

const ROS_TYPE_NAME = "rcl_interfaces/msg/ParameterEventDescriptors"

func _init():
	init(ROS_TYPE_NAME)

var new_parameters : Array:
	get: return get_member(&"new_parameters")
	set(v): set_member(&"new_parameters", v)

var changed_parameters : Array:
	get: return get_member(&"changed_parameters")
	set(v): set_member(&"changed_parameters", v)

var deleted_parameters : Array:
	get: return get_member(&"deleted_parameters")
	set(v): set_member(&"deleted_parameters", v)

