extends RosMsg
class_name RosRosGzInterfacesContacts

func _init():
	init("ros_gz_interfaces/msg/Contacts")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var contacts : Array:
	get: return get_member(&"contacts")
	set(v): set_member(&"contacts", v)

