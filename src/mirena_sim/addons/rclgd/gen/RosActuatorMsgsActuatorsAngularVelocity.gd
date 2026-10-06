extends RosMsg
class_name RosActuatorMsgsActuatorsAngularVelocity

func _init():
	init("actuator_msgs/msg/ActuatorsAngularVelocity")

var velocity : PackedFloat64Array:
	get: return get_member(&"velocity")
	set(v): set_member(&"velocity", v)

