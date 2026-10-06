extends RosMsg
class_name RosGpsMsgsGpsStatus

func _init():
	init("gps_msgs/msg/GPSStatus")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var satellites_used : int:
	get: return get_member(&"satellites_used")
	set(v): set_member(&"satellites_used", v)

var satellite_used_prn : Array:
	get: return get_member(&"satellite_used_prn")
	set(v): set_member(&"satellite_used_prn", v)

var satellites_visible : int:
	get: return get_member(&"satellites_visible")
	set(v): set_member(&"satellites_visible", v)

var satellite_visible_prn : Array:
	get: return get_member(&"satellite_visible_prn")
	set(v): set_member(&"satellite_visible_prn", v)

var satellite_visible_z : Array:
	get: return get_member(&"satellite_visible_z")
	set(v): set_member(&"satellite_visible_z", v)

var satellite_visible_azimuth : Array:
	get: return get_member(&"satellite_visible_azimuth")
	set(v): set_member(&"satellite_visible_azimuth", v)

var satellite_visible_snr : Array:
	get: return get_member(&"satellite_visible_snr")
	set(v): set_member(&"satellite_visible_snr", v)

var status : int:
	get: return get_member(&"status")
	set(v): set_member(&"status", v)

var motion_source : int:
	get: return get_member(&"motion_source")
	set(v): set_member(&"motion_source", v)

var orientation_source : int:
	get: return get_member(&"orientation_source")
	set(v): set_member(&"orientation_source", v)

var position_source : int:
	get: return get_member(&"position_source")
	set(v): set_member(&"position_source", v)

