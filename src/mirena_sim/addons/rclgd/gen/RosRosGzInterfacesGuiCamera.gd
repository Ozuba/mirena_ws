extends RosMsg
class_name RosRosGzInterfacesGuiCamera

func _init():
	init("ros_gz_interfaces/msg/GuiCamera")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var view_controller : String:
	get: return get_member(&"view_controller")
	set(v): set_member(&"view_controller", v)

var pose : RosGeometryMsgsPose:
	get: return get_member(&"pose") as RosMsg
	set(v): set_member(&"pose", v)

var track : RosRosGzInterfacesTrackVisual:
	get: return get_member(&"track") as RosMsg
	set(v): set_member(&"track", v)

var projection_type : String:
	get: return get_member(&"projection_type")
	set(v): set_member(&"projection_type", v)

