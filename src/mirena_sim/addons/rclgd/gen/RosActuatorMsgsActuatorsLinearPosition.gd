extends RosMsg
class_name RosActuatorMsgsActuatorsLinearPosition

func _init():
	init("actuator_msgs/msg/ActuatorsLinearPosition")

var position : PackedFloat64Array:
	get: return get_member(&"position")
	set(v): set_member(&"position", v)

