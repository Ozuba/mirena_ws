extends RosMsg
class_name RosRosGzInterfacesEntity

func _init():
	init("ros_gz_interfaces/msg/Entity")

var id : int:
	get: return get_member(&"id")
	set(v): set_member(&"id", v)

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var type : int:
	get: return get_member(&"type")
	set(v): set_member(&"type", v)

