extends RosMsg
class_name RosRosGzInterfacesJointWrench

func _init():
	init("ros_gz_interfaces/msg/JointWrench")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var body_1_name : RosStdMsgsString:
	get: return get_member(&"body_1_name") as RosMsg
	set(v): set_member(&"body_1_name", v)

var body_1_id : RosStdMsgsUInt32:
	get: return get_member(&"body_1_id") as RosMsg
	set(v): set_member(&"body_1_id", v)

var body_2_name : RosStdMsgsString:
	get: return get_member(&"body_2_name") as RosMsg
	set(v): set_member(&"body_2_name", v)

var body_2_id : RosStdMsgsUInt32:
	get: return get_member(&"body_2_id") as RosMsg
	set(v): set_member(&"body_2_id", v)

var body_1_wrench : RosGeometryMsgsWrench:
	get: return get_member(&"body_1_wrench") as RosMsg
	set(v): set_member(&"body_1_wrench", v)

var body_2_wrench : RosGeometryMsgsWrench:
	get: return get_member(&"body_2_wrench") as RosMsg
	set(v): set_member(&"body_2_wrench", v)

