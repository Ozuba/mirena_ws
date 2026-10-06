extends RosMsg
class_name RosMirenaCommonBezierCurvePoint

func _init():
	init("mirena_common/msg/BezierCurvePoint")

var point : RosGeometryMsgsPoint:
	get: return get_member(&"point") as RosMsg
	set(v): set_member(&"point", v)

var in_control_point : RosGeometryMsgsPoint:
	get: return get_member(&"in_control_point") as RosMsg
	set(v): set_member(&"in_control_point", v)

var out_control_point : RosGeometryMsgsPoint:
	get: return get_member(&"out_control_point") as RosMsg
	set(v): set_member(&"out_control_point", v)

