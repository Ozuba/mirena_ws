extends RosMsg
class_name RosActuatorMsgsActuators

func _init():
	init("actuator_msgs/msg/Actuators")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var position : PackedFloat64Array:
	get: return get_member(&"position")
	set(v): set_member(&"position", v)

var velocity : PackedFloat64Array:
	get: return get_member(&"velocity")
	set(v): set_member(&"velocity", v)

var normalized : PackedFloat64Array:
	get: return get_member(&"normalized")
	set(v): set_member(&"normalized", v)

