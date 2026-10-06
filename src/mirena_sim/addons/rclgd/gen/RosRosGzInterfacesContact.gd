extends RosMsg
class_name RosRosGzInterfacesContact

func _init():
	init("ros_gz_interfaces/msg/Contact")

var collision1 : RosRosGzInterfacesEntity:
	get: return get_member(&"collision1") as RosMsg
	set(v): set_member(&"collision1", v)

var collision2 : RosRosGzInterfacesEntity:
	get: return get_member(&"collision2") as RosMsg
	set(v): set_member(&"collision2", v)

var positions : Array:
	get: return get_member(&"positions")
	set(v): set_member(&"positions", v)

var normals : Array:
	get: return get_member(&"normals")
	set(v): set_member(&"normals", v)

var depths : PackedFloat64Array:
	get: return get_member(&"depths")
	set(v): set_member(&"depths", v)

var wrenches : Array:
	get: return get_member(&"wrenches")
	set(v): set_member(&"wrenches", v)

