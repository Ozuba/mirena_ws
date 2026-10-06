extends RosMsg
class_name RosSimulationInterfacesEntityState

func _init():
	init("simulation_interfaces/msg/EntityState")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var pose : RosGeometryMsgsPose:
	get: return get_member(&"pose") as RosMsg
	set(v): set_member(&"pose", v)

var twist : RosGeometryMsgsTwist:
	get: return get_member(&"twist") as RosMsg
	set(v): set_member(&"twist", v)

var acceleration : RosGeometryMsgsAccel:
	get: return get_member(&"acceleration") as RosMsg
	set(v): set_member(&"acceleration", v)

