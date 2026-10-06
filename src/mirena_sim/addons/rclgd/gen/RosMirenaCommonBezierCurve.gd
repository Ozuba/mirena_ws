extends RosMsg
class_name RosMirenaCommonBezierCurve

func _init():
	init("mirena_common/msg/BezierCurve")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var points : Array:
	get: return get_member(&"points")
	set(v): set_member(&"points", v)

var is_closed : bool:
	get: return get_member(&"is_closed")
	set(v): set_member(&"is_closed", v)

