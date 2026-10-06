extends RosMsg
class_name RosRosGzInterfacesFloat32Array

func _init():
	init("ros_gz_interfaces/msg/Float32Array")

var data : PackedFloat32Array:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

