extends RosMsg
class_name RosMirenaCommonCanDvDrivingDyn2

func _init():
	init("mirena_common/msg/CanDvDrivingDyn2")

var abs_request : bool:
	get: return get_member(&"abs_request")
	set(v): set_member(&"abs_request", v)

