extends RosMsg
class_name RosMarineAcousticMsgsSonarImageData

func _init():
	init("marine_acoustic_msgs/msg/SonarImageData")

var is_bigendian : bool:
	get: return get_member(&"is_bigendian")
	set(v): set_member(&"is_bigendian", v)

var dtype : int:
	get: return get_member(&"dtype")
	set(v): set_member(&"dtype", v)

var beam_count : int:
	get: return get_member(&"beam_count")
	set(v): set_member(&"beam_count", v)

var data : PackedByteArray:
	get: return get_member(&"data")
	set(v): set_member(&"data", v)

