extends RosMsg
class_name RosActuatorMsgsActuatorsNormalized

func _init():
	init("actuator_msgs/msg/ActuatorsNormalized")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var normalized : PackedFloat64Array:
	get: return get_member(&"normalized")
	set(v): set_member(&"normalized", v)

