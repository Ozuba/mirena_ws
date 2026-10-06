extends RosMsg
class_name RosMirenaCommonCar

const ROS_TYPE_NAME = "mirena_common/msg/Car"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var x : float:
	get: return get_member(&"x")
	set(v): set_member(&"x", v)

var y : float:
	get: return get_member(&"y")
	set(v): set_member(&"y", v)

var psi : float:
	get: return get_member(&"psi")
	set(v): set_member(&"psi", v)

var child_frame_id : String:
	get: return get_member(&"child_frame_id")
	set(v): set_member(&"child_frame_id", v)

var u : float:
	get: return get_member(&"u")
	set(v): set_member(&"u", v)

var v : float:
	get: return get_member(&"v")
	set(v): set_member(&"v", v)

var omega : float:
	get: return get_member(&"omega")
	set(v): set_member(&"omega", v)

var covariance : PackedFloat64Array:
	get: return get_member(&"covariance")
	set(v): set_member(&"covariance", v)

