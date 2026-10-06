extends RosMsg
class_name RosRclInterfacesParameterEvent

const ROS_TYPE_NAME = "rcl_interfaces/msg/ParameterEvent"

func _init():
	init(ROS_TYPE_NAME)

var stamp : RosBuiltinInterfacesTime:
	get: return get_member(&"stamp") as RosMsg
	set(v): set_member(&"stamp", v)

var node : String:
	get: return get_member(&"node")
	set(v): set_member(&"node", v)

var new_parameters : Array:
	get: return get_member(&"new_parameters")
	set(v): set_member(&"new_parameters", v)

var changed_parameters : Array:
	get: return get_member(&"changed_parameters")
	set(v): set_member(&"changed_parameters", v)

var deleted_parameters : Array:
	get: return get_member(&"deleted_parameters")
	set(v): set_member(&"deleted_parameters", v)

