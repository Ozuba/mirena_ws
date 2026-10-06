extends RosMsg
class_name RosMarineAcousticMsgsPingInfo

func _init():
	init("marine_acoustic_msgs/msg/PingInfo")

var frequency : float:
	get: return get_member(&"frequency")
	set(v): set_member(&"frequency", v)

var sound_speed : float:
	get: return get_member(&"sound_speed")
	set(v): set_member(&"sound_speed", v)

var tx_beamwidths : PackedFloat32Array:
	get: return get_member(&"tx_beamwidths")
	set(v): set_member(&"tx_beamwidths", v)

var rx_beamwidths : PackedFloat32Array:
	get: return get_member(&"rx_beamwidths")
	set(v): set_member(&"rx_beamwidths", v)

