extends RosMsg
class_name RosMarineAcousticMsgsDvl

func _init():
	init("marine_acoustic_msgs/msg/Dvl")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var velocity_mode : int:
	get: return get_member(&"velocity_mode")
	set(v): set_member(&"velocity_mode", v)

var dvl_type : int:
	get: return get_member(&"dvl_type")
	set(v): set_member(&"dvl_type", v)

var velocity : RosGeometryMsgsVector3:
	get: return get_member(&"velocity") as RosMsg
	set(v): set_member(&"velocity", v)

var velocity_covar : PackedFloat64Array:
	get: return get_member(&"velocity_covar")
	set(v): set_member(&"velocity_covar", v)

var altitude : float:
	get: return get_member(&"altitude")
	set(v): set_member(&"altitude", v)

var course_gnd : float:
	get: return get_member(&"course_gnd")
	set(v): set_member(&"course_gnd", v)

var speed_gnd : float:
	get: return get_member(&"speed_gnd")
	set(v): set_member(&"speed_gnd", v)

var num_good_beams : int:
	get: return get_member(&"num_good_beams")
	set(v): set_member(&"num_good_beams", v)

var sound_speed : float:
	get: return get_member(&"sound_speed")
	set(v): set_member(&"sound_speed", v)

var beam_ranges_valid : bool:
	get: return get_member(&"beam_ranges_valid")
	set(v): set_member(&"beam_ranges_valid", v)

var beam_velocities_valid : bool:
	get: return get_member(&"beam_velocities_valid")
	set(v): set_member(&"beam_velocities_valid", v)

