extends RosMsg
class_name RosRclInterfacesParameterValue

const ROS_TYPE_NAME = "rcl_interfaces/msg/ParameterValue"

func _init():
	init(ROS_TYPE_NAME)

var type : int:
	get: return get_member(&"type")
	set(v): set_member(&"type", v)

var bool_value : bool:
	get: return get_member(&"bool_value")
	set(v): set_member(&"bool_value", v)

var integer_value : int:
	get: return get_member(&"integer_value")
	set(v): set_member(&"integer_value", v)

var double_value : float:
	get: return get_member(&"double_value")
	set(v): set_member(&"double_value", v)

var string_value : String:
	get: return get_member(&"string_value")
	set(v): set_member(&"string_value", v)

var byte_array_value : PackedByteArray:
	get: return get_member(&"byte_array_value")
	set(v): set_member(&"byte_array_value", v)

var bool_array_value : Array:
	get: return get_member(&"bool_array_value")
	set(v): set_member(&"bool_array_value", v)

var integer_array_value : Array:
	get: return get_member(&"integer_array_value")
	set(v): set_member(&"integer_array_value", v)

var double_array_value : PackedFloat64Array:
	get: return get_member(&"double_array_value")
	set(v): set_member(&"double_array_value", v)

var string_array_value : PackedStringArray:
	get: return get_member(&"string_array_value")
	set(v): set_member(&"string_array_value", v)

