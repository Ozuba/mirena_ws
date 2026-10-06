extends RosMsg
class_name RosRosGzInterfacesDataframe

func _init():
	init("ros_gz_interfaces/msg/Dataframe")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var src_address : String:
	get: return get_member(&"src_address")
	set(v): set_member(&"src_address", v)

var dst_address : String:
	get: return get_member(&"dst_address")
	set(v): set_member(&"dst_address", v)

var data : PackedByteArray:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

var rssi : float:
	get: return get_member(&"rssi")
	set(v): set_member(&"rssi", v)

