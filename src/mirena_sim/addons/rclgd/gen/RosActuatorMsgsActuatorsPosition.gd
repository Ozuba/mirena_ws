extends RosMsg
class_name RosActuatorMsgsActuatorsPosition

func _init():
	init("actuator_msgs/msg/ActuatorsPosition")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var angular : RosActuatorMsgsActuatorsAngularPosition:
	get: return get_member(&"angular") as RosMsg
	set(v): set_member(&"angular", v)

var linear : RosActuatorMsgsActuatorsLinearPosition:
	get: return get_member(&"linear") as RosMsg
	set(v): set_member(&"linear", v)

