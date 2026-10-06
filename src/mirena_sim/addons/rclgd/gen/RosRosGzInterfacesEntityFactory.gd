extends RosMsg
class_name RosRosGzInterfacesEntityFactory

func _init():
	init("ros_gz_interfaces/msg/EntityFactory")

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var allow_renaming : bool:
	get: return get_member(&"allow_renaming")
	set(v): set_member(&"allow_renaming", v)

var sdf : String:
	get: return get_member(&"sdf")
	set(v): set_member(&"sdf", v)

var sdf_filename : String:
	get: return get_member(&"sdf_filename")
	set(v): set_member(&"sdf_filename", v)

var clone_name : String:
	get: return get_member(&"clone_name")
	set(v): set_member(&"clone_name", v)

var pose : RosGeometryMsgsPose:
	get: return get_member(&"pose") as RosMsg
	set(v): set_member(&"pose", v)

var relative_to : String:
	get: return get_member(&"relative_to")
	set(v): set_member(&"relative_to", v)

