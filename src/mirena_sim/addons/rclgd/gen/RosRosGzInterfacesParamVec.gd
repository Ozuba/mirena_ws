extends RosMsg
class_name RosRosGzInterfacesParamVec

func _init():
	init("ros_gz_interfaces/msg/ParamVec")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var params : Array:
	get: return get_member(&"params")
	set(v): set_member(&"params", v)

