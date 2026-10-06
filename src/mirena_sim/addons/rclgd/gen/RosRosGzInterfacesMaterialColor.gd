extends RosMsg
class_name RosRosGzInterfacesMaterialColor

func _init():
	init("ros_gz_interfaces/msg/MaterialColor")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var entity : RosRosGzInterfacesEntity:
	get: return get_member(&"entity") as RosMsg
	set(v): set_member(&"entity", v)

var ambient : RosStdMsgsColorRgba:
	get: return get_member(&"ambient") as RosMsg
	set(v): set_member(&"ambient", v)

var diffuse : RosStdMsgsColorRgba:
	get: return get_member(&"diffuse") as RosMsg
	set(v): set_member(&"diffuse", v)

var specular : RosStdMsgsColorRgba:
	get: return get_member(&"specular") as RosMsg
	set(v): set_member(&"specular", v)

var emissive : RosStdMsgsColorRgba:
	get: return get_member(&"emissive") as RosMsg
	set(v): set_member(&"emissive", v)

var shininess : float:
	get: return get_member(&"shininess")
	set(v): set_member(&"shininess", v)

var entity_match : int:
	get: return get_member(&"entity_match")
	set(v): set_member(&"entity_match", v)

