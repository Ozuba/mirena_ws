extends RosMsg
class_name RosRosGzInterfacesTrackVisual

func _init():
	init("ros_gz_interfaces/msg/TrackVisual")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var id : int:
	get: return get_member(&"id")
	set(v): set_member(&"id", v)

var inherit_orientation : bool:
	get: return get_member(&"inherit_orientation")
	set(v): set_member(&"inherit_orientation", v)

var min_dist : float:
	get: return get_member(&"min_dist")
	set(v): set_member(&"min_dist", v)

var max_dist : float:
	get: return get_member(&"max_dist")
	set(v): set_member(&"max_dist", v)

var is_static : bool:
	get: return get_member(&"is_static")
	set(v): set_member(&"is_static", v)

var use_model_frame : bool:
	get: return get_member(&"use_model_frame")
	set(v): set_member(&"use_model_frame", v)

var xyz : RosGeometryMsgsVector3:
	get: return get_member(&"xyz") as RosMsg
	set(v): set_member(&"xyz", v)

var inherit_yaw : bool:
	get: return get_member(&"inherit_yaw")
	set(v): set_member(&"inherit_yaw", v)

