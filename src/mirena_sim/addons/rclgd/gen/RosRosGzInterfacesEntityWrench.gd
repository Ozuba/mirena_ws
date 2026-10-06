extends RosMsg
class_name RosRosGzInterfacesEntityWrench

func _init():
	init("ros_gz_interfaces/msg/EntityWrench")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var entity : RosRosGzInterfacesEntity:
	get: return get_member(&"entity") as RosMsg
	set(v): set_member(&"entity", v)

var wrench : RosGeometryMsgsWrench:
	get: return get_member(&"wrench") as RosMsg
	set(v): set_member(&"wrench", v)

