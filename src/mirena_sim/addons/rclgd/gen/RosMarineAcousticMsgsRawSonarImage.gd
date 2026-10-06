extends RosMsg
class_name RosMarineAcousticMsgsRawSonarImage

func _init():
	init("marine_acoustic_msgs/msg/RawSonarImage")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var ping_info : RosMarineAcousticMsgsPingInfo:
	get: return get_member(&"ping_info") as RosMsg
	set(v): set_member(&"ping_info", v)

var sample_rate : float:
	get: return get_member(&"sample_rate")
	set(v): set_member(&"sample_rate", v)

var samples_per_beam : int:
	get: return get_member(&"samples_per_beam")
	set(v): set_member(&"samples_per_beam", v)

var sample0 : int:
	get: return get_member(&"sample0")
	set(v): set_member(&"sample0", v)

var tx_delays : PackedFloat32Array:
	get: return get_member(&"tx_delays")
	set(v): set_member(&"tx_delays", v)

var tx_angles : PackedFloat32Array:
	get: return get_member(&"tx_angles")
	set(v): set_member(&"tx_angles", v)

var rx_angles : PackedFloat32Array:
	get: return get_member(&"rx_angles")
	set(v): set_member(&"rx_angles", v)

var image : RosMarineAcousticMsgsSonarImageData:
	get: return get_member(&"image") as RosMsg
	set(v): set_member(&"image", v)

