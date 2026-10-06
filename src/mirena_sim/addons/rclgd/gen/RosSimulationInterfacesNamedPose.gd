extends RosMsg
class_name RosSimulationInterfacesNamedPose

func _init():
	init("simulation_interfaces/msg/NamedPose")

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var description : String:
	get: return get_member(&"description")
	set(v): set_member(&"description", v)

var tags : PackedStringArray:
	get: return get_member(&"tags")
	set(v): set_member(&"tags", v)

var pose : RosGeometryMsgsPose:
	get: return get_member(&"pose") as RosMsg
	set(v): set_member(&"pose", v)

