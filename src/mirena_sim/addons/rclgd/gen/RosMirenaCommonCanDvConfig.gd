extends RosMsg
class_name RosMirenaCommonCanDvConfig

func _init():
	init("mirena_common/msg/CanDvConfig")

var mission_select : RosMirenaCommonMissionType:
	get: return get_member(&"mission_select") as RosMsg
	set(v): set_member(&"mission_select", v)
