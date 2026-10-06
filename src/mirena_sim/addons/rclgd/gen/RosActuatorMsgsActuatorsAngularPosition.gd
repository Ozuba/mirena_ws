extends RosMsg
class_name RosActuatorMsgsActuatorsAngularPosition

func _init():
	init("actuator_msgs/msg/ActuatorsAngularPosition")

var position : PackedFloat64Array:
	get: return get_member(&"position")
	set(v): set_member(&"position", v)

