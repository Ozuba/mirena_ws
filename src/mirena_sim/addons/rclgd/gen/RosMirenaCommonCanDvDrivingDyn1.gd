extends RosMsg
class_name RosMirenaCommonCanDvDrivingDyn1

func _init():
	init("mirena_common/msg/CanDvDrivingDyn1")

var torque_req : float:
	get: return get_member(&"torque_req")
	set(v): set_member(&"torque_req", v)

var steer_req : float:
	get: return get_member(&"steer_req")
	set(v): set_member(&"steer_req", v)

