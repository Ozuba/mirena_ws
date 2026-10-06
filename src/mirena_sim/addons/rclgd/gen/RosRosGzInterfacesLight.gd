extends RosMsg
class_name RosRosGzInterfacesLight

func _init():
	init("ros_gz_interfaces/msg/Light")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var type : int:
	get: return get_member(&"type")
	set(v): set_member(&"type", v)

var pose : RosGeometryMsgsPose:
	get: return get_member(&"pose") as RosMsg
	set(v): set_member(&"pose", v)

var diffuse : RosStdMsgsColorRgba:
	get: return get_member(&"diffuse") as RosMsg
	set(v): set_member(&"diffuse", v)

var specular : RosStdMsgsColorRgba:
	get: return get_member(&"specular") as RosMsg
	set(v): set_member(&"specular", v)

var attenuation_constant : float:
	get: return get_member(&"attenuation_constant")
	set(v): set_member(&"attenuation_constant", v)

var attenuation_linear : float:
	get: return get_member(&"attenuation_linear")
	set(v): set_member(&"attenuation_linear", v)

var attenuation_quadratic : float:
	get: return get_member(&"attenuation_quadratic")
	set(v): set_member(&"attenuation_quadratic", v)

var direction : RosGeometryMsgsVector3:
	get: return get_member(&"direction") as RosMsg
	set(v): set_member(&"direction", v)

var range : float:
	get: return get_member(&"range")
	set(v): set_member(&"range", v)

var cast_shadows : bool:
	get: return get_member(&"cast_shadows")
	set(v): set_member(&"cast_shadows", v)

var spot_inner_angle : float:
	get: return get_member(&"spot_inner_angle")
	set(v): set_member(&"spot_inner_angle", v)

var spot_outer_angle : float:
	get: return get_member(&"spot_outer_angle")
	set(v): set_member(&"spot_outer_angle", v)

var spot_falloff : float:
	get: return get_member(&"spot_falloff")
	set(v): set_member(&"spot_falloff", v)

var id : int:
	get: return get_member(&"id")
	set(v): set_member(&"id", v)

var parent_id : int:
	get: return get_member(&"parent_id")
	set(v): set_member(&"parent_id", v)

var intensity : float:
	get: return get_member(&"intensity")
	set(v): set_member(&"intensity", v)

