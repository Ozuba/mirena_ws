extends RosMsg
class_name RosMarineAcousticMsgsProjectedSonarImage

func _init():
	init("marine_acoustic_msgs/msg/ProjectedSonarImage")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var ping_info : RosMarineAcousticMsgsPingInfo:
	get: return get_member(&"ping_info") as RosMsg
	set(v): set_member(&"ping_info", v)

var beam_directions : Array:
	get: return get_member(&"beam_directions")
	set(v): set_member(&"beam_directions", v)

var ranges : PackedFloat32Array:
	get: return get_member(&"ranges")
	set(v): set_member(&"ranges", v)

var image : RosMarineAcousticMsgsSonarImageData:
	get: return get_member(&"image") as RosMsg
	set(v): set_member(&"image", v)

