extends RosMsg
class_name RosTheoraImageTransportPacket

func _init():
	init("theora_image_transport/msg/Packet")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var data : PackedByteArray:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

var b_o_s : int:
	get: return get_member(&"b_o_s")
	set(v): set_member(&"b_o_s", v)

var e_o_s : int:
	get: return get_member(&"e_o_s")
	set(v): set_member(&"e_o_s", v)

var granulepos : int:
	get: return get_member(&"granulepos")
	set(v): set_member(&"granulepos", v)

var packetno : int:
	get: return get_member(&"packetno")
	set(v): set_member(&"packetno", v)

