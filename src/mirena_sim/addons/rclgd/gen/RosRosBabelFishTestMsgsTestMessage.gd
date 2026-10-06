extends RosMsg
class_name RosRosBabelFishTestMsgsTestMessage

func _init():
	init("ros_babel_fish_test_msgs/msg/TestMessage")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var b : bool:
	get: return get_member(&"b")
	set(v): set_member(&"b", v)

var ui8 : int:
	get: return get_member(&"ui8")
	set(v): set_member(&"ui8", v)

var ui16 : int:
	get: return get_member(&"ui16")
	set(v): set_member(&"ui16", v)

var ui32 : int:
	get: return get_member(&"ui32")
	set(v): set_member(&"ui32", v)

var ui64 : int:
	get: return get_member(&"ui64")
	set(v): set_member(&"ui64", v)

var i8 : int:
	get: return get_member(&"i8")
	set(v): set_member(&"i8", v)

var i16 : int:
	get: return get_member(&"i16")
	set(v): set_member(&"i16", v)

var i32 : int:
	get: return get_member(&"i32")
	set(v): set_member(&"i32", v)

var i64 : int:
	get: return get_member(&"i64")
	set(v): set_member(&"i64", v)

var f32 : float:
	get: return get_member(&"f32")
	set(v): set_member(&"f32", v)

var f64 : float:
	get: return get_member(&"f64")
	set(v): set_member(&"f64", v)

var str : String:
	get: return get_member(&"str")
	set(v): set_member(&"str", v)

var bounded_str : String:
	get: return get_member(&"bounded_str")
	set(v): set_member(&"bounded_str", v)

var t : RosBuiltinInterfacesTime:
	get: return get_member(&"t") as RosMsg
	set(v): set_member(&"t", v)

var d : RosBuiltinInterfacesDuration:
	get: return get_member(&"d") as RosMsg
	set(v): set_member(&"d", v)

var point_arr : Array:
	get: return get_member(&"point_arr")
	set(v): set_member(&"point_arr", v)

