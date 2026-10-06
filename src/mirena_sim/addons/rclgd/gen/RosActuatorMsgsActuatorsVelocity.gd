extends RosMsg
class_name RosActuatorMsgsActuatorsVelocity

func _init():
	init("actuator_msgs/msg/ActuatorsVelocity")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var angular : RosActuatorMsgsActuatorsAngularVelocity:
	get: return get_member(&"angular") as RosMsg
	set(v): set_member(&"angular", v)

var linear : RosActuatorMsgsActuatorsLinearVelocity:
	get: return get_member(&"linear") as RosMsg
	set(v): set_member(&"linear", v)

