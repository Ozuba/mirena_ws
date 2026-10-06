extends RosMsg
class_name RosTestMsgsBasicTypes

func _init():
	init("test_msgs/msg/BasicTypes")

var bool_value : bool:
	get: return get_member(&"bool_value")
	set(v): set_member(&"bool_value", v)

var byte_value : int:
	get: return get_member(&"byte_value")
	set(v): set_member(&"byte_value", v)

var char_value : int:
	get: return get_member(&"char_value")
	set(v): set_member(&"char_value", v)

var float32_value : float:
	get: return get_member(&"float32_value")
	set(v): set_member(&"float32_value", v)

var float64_value : float:
	get: return get_member(&"float64_value")
	set(v): set_member(&"float64_value", v)

var int8_value : int:
	get: return get_member(&"int8_value")
	set(v): set_member(&"int8_value", v)

var uint8_value : int:
	get: return get_member(&"uint8_value")
	set(v): set_member(&"uint8_value", v)

var int16_value : int:
	get: return get_member(&"int16_value")
	set(v): set_member(&"int16_value", v)

var uint16_value : int:
	get: return get_member(&"uint16_value")
	set(v): set_member(&"uint16_value", v)

var int32_value : int:
	get: return get_member(&"int32_value")
	set(v): set_member(&"int32_value", v)

var uint32_value : int:
	get: return get_member(&"uint32_value")
	set(v): set_member(&"uint32_value", v)

var int64_value : int:
	get: return get_member(&"int64_value")
	set(v): set_member(&"int64_value", v)

var uint64_value : int:
	get: return get_member(&"uint64_value")
	set(v): set_member(&"uint64_value", v)

