extends RosMsg
class_name RosMirenaCommonMissionType

func _init():
	init("mirena_common/msg/MissionType")

var mission : int:
	get: return get_member(&"mission")
	set(v): set_member(&"mission", v)

