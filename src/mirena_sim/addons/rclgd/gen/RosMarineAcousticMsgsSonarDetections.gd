extends RosMsg
class_name RosMarineAcousticMsgsSonarDetections

func _init():
	init("marine_acoustic_msgs/msg/SonarDetections")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var ping_info : RosMarineAcousticMsgsPingInfo:
	get: return get_member(&"ping_info") as RosMsg
	set(v): set_member(&"ping_info", v)

var flags : Array:
	get: return get_member(&"flags")
	set(v): set_member(&"flags", v)

var two_way_travel_times : PackedFloat32Array:
	get: return get_member(&"two_way_travel_times")
	set(v): set_member(&"two_way_travel_times", v)

var tx_delays : PackedFloat32Array:
	get: return get_member(&"tx_delays")
	set(v): set_member(&"tx_delays", v)

var intensities : PackedFloat32Array:
	get: return get_member(&"intensities")
	set(v): set_member(&"intensities", v)

var tx_angles : PackedFloat32Array:
	get: return get_member(&"tx_angles")
	set(v): set_member(&"tx_angles", v)

var rx_angles : PackedFloat32Array:
	get: return get_member(&"rx_angles")
	set(v): set_member(&"rx_angles", v)

