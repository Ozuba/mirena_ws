extends RosMsg
class_name RosRosBabelFishTestMsgsTestArray

func _init():
	init("ros_babel_fish_test_msgs/msg/TestArray")

var bools : Array:
	get: return get_member(&"bools")
	set(v): set_member(&"bools", v)

var uint8s : PackedByteArray:
	get: return get_member(&"uint8s")
	set(v): set_member(&"uint8s", v)

var uint16s : Array:
	get: return get_member(&"uint16s")
	set(v): set_member(&"uint16s", v)

var uint32s : Array:
	get: return get_member(&"uint32s")
	set(v): set_member(&"uint32s", v)

var uint64s : Array:
	get: return get_member(&"uint64s")
	set(v): set_member(&"uint64s", v)

var int8s : Array:
	get: return get_member(&"int8s")
	set(v): set_member(&"int8s", v)

var int16s : Array:
	get: return get_member(&"int16s")
	set(v): set_member(&"int16s", v)

var int32s : Array:
	get: return get_member(&"int32s")
	set(v): set_member(&"int32s", v)

var int64s : Array:
	get: return get_member(&"int64s")
	set(v): set_member(&"int64s", v)

var float32s : PackedFloat32Array:
	get: return get_member(&"float32s")
	set(v): set_member(&"float32s", v)

var float64s : PackedFloat64Array:
	get: return get_member(&"float64s")
	set(v): set_member(&"float64s", v)

var times : Array:
	get: return get_member(&"times")
	set(v): set_member(&"times", v)

