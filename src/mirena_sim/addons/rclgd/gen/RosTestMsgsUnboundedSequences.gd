extends RosMsg
class_name RosTestMsgsUnboundedSequences

func _init():
	init("test_msgs/msg/UnboundedSequences")

var bool_values : Array:
	get: return get_member(&"bool_values")
	set(v): set_member(&"bool_values", v)

var byte_values : PackedByteArray:
	get: return get_member(&"byte_values")
	set(v): set_member(&"byte_values", v)

var char_values : PackedByteArray:
	get: return get_member(&"char_values")
	set(v): set_member(&"char_values", v)

var float32_values : PackedFloat32Array:
	get: return get_member(&"float32_values")
	set(v): set_member(&"float32_values", v)

var float64_values : PackedFloat64Array:
	get: return get_member(&"float64_values")
	set(v): set_member(&"float64_values", v)

var int8_values : Array:
	get: return get_member(&"int8_values")
	set(v): set_member(&"int8_values", v)

var uint8_values : PackedByteArray:
	get: return get_member(&"uint8_values")
	set(v): set_member(&"uint8_values", v)

var int16_values : Array:
	get: return get_member(&"int16_values")
	set(v): set_member(&"int16_values", v)

var uint16_values : Array:
	get: return get_member(&"uint16_values")
	set(v): set_member(&"uint16_values", v)

var int32_values : Array:
	get: return get_member(&"int32_values")
	set(v): set_member(&"int32_values", v)

var uint32_values : Array:
	get: return get_member(&"uint32_values")
	set(v): set_member(&"uint32_values", v)

var int64_values : Array:
	get: return get_member(&"int64_values")
	set(v): set_member(&"int64_values", v)

var uint64_values : Array:
	get: return get_member(&"uint64_values")
	set(v): set_member(&"uint64_values", v)

var string_values : PackedStringArray:
	get: return get_member(&"string_values")
	set(v): set_member(&"string_values", v)

var basic_types_values : Array:
	get: return get_member(&"basic_types_values")
	set(v): set_member(&"basic_types_values", v)

var constants_values : Array:
	get: return get_member(&"constants_values")
	set(v): set_member(&"constants_values", v)

var defaults_values : Array:
	get: return get_member(&"defaults_values")
	set(v): set_member(&"defaults_values", v)

var bool_values_default : Array:
	get: return get_member(&"bool_values_default")
	set(v): set_member(&"bool_values_default", v)

var byte_values_default : PackedByteArray:
	get: return get_member(&"byte_values_default")
	set(v): set_member(&"byte_values_default", v)

var char_values_default : PackedByteArray:
	get: return get_member(&"char_values_default")
	set(v): set_member(&"char_values_default", v)

var float32_values_default : PackedFloat32Array:
	get: return get_member(&"float32_values_default")
	set(v): set_member(&"float32_values_default", v)

var float64_values_default : PackedFloat64Array:
	get: return get_member(&"float64_values_default")
	set(v): set_member(&"float64_values_default", v)

var int8_values_default : Array:
	get: return get_member(&"int8_values_default")
	set(v): set_member(&"int8_values_default", v)

var uint8_values_default : PackedByteArray:
	get: return get_member(&"uint8_values_default")
	set(v): set_member(&"uint8_values_default", v)

var int16_values_default : Array:
	get: return get_member(&"int16_values_default")
	set(v): set_member(&"int16_values_default", v)

var uint16_values_default : Array:
	get: return get_member(&"uint16_values_default")
	set(v): set_member(&"uint16_values_default", v)

var int32_values_default : Array:
	get: return get_member(&"int32_values_default")
	set(v): set_member(&"int32_values_default", v)

var uint32_values_default : Array:
	get: return get_member(&"uint32_values_default")
	set(v): set_member(&"uint32_values_default", v)

var int64_values_default : Array:
	get: return get_member(&"int64_values_default")
	set(v): set_member(&"int64_values_default", v)

var uint64_values_default : Array:
	get: return get_member(&"uint64_values_default")
	set(v): set_member(&"uint64_values_default", v)

var string_values_default : PackedStringArray:
	get: return get_member(&"string_values_default")
	set(v): set_member(&"string_values_default", v)

var alignment_check : int:
	get: return get_member(&"alignment_check")
	set(v): set_member(&"alignment_check", v)

