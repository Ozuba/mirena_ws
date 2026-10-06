extends RosMsg
class_name RosMarineAcousticMsgsSonarRanges

func _init():
	init("marine_acoustic_msgs/msg/SonarRanges")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var ping_info : RosMarineAcousticMsgsPingInfo:
	get: return get_member(&"ping_info") as RosMsg
	set(v): set_member(&"ping_info", v)

var flags : Array:
	get: return get_member(&"flags")
	set(v): set_member(&"flags", v)

var transmit_delays : PackedFloat32Array:
	get: return get_member(&"transmit_delays")
	set(v): set_member(&"transmit_delays", v)

var intensities : PackedFloat32Array:
	get: return get_member(&"intensities")
	set(v): set_member(&"intensities", v)

var beam_unit_vec : Array:
	get: return get_member(&"beam_unit_vec")
	set(v): set_member(&"beam_unit_vec", v)

var ranges : PackedFloat32Array:
	get: return get_member(&"ranges")
	set(v): set_member(&"ranges", v)

