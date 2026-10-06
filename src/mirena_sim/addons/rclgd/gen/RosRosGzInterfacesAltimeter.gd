extends RosMsg
class_name RosRosGzInterfacesAltimeter

func _init():
	init("ros_gz_interfaces/msg/Altimeter")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var vertical_position : float:
	get: return get_member(&"vertical_position")
	set(v): set_member(&"vertical_position", v)

var vertical_velocity : float:
	get: return get_member(&"vertical_velocity")
	set(v): set_member(&"vertical_velocity", v)

var vertical_reference : float:
	get: return get_member(&"vertical_reference")
	set(v): set_member(&"vertical_reference", v)

