extends RosMsg
class_name RosActuatorMsgsActuatorsLinearVelocity

func _init():
	init("actuator_msgs/msg/ActuatorsLinearVelocity")

var velocity : PackedFloat64Array:
	get: return get_member(&"velocity")
	set(v): set_member(&"velocity", v)

