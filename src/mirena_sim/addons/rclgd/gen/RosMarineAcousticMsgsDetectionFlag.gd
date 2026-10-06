extends RosMsg
class_name RosMarineAcousticMsgsDetectionFlag

func _init():
	init("marine_acoustic_msgs/msg/DetectionFlag")

var flag : int:
	get: return get_member(&"flag")
	set(v): set_member(&"flag", v)

