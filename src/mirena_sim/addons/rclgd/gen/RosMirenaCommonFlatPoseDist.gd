extends RosMsg
class_name RosMirenaCommonFlatPoseDist

const ROS_TYPE_NAME = "mirena_common/msg/FlatPoseDist"

func _init():
	init(ROS_TYPE_NAME)

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var mean : PackedFloat64Array:
	get: return get_member(&"mean")
	set(v): set_member(&"mean", v)

var covariance : PackedFloat64Array:
	get: return get_member(&"covariance")
	set(v): set_member(&"covariance", v)

