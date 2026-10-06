extends RosMsg
class_name RosGpsMsgsGpsFix

func _init():
	init("gps_msgs/msg/GPSFix")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var status : RosGpsMsgsGpsStatus:
	get: return get_member(&"status") as RosMsg
	set(v): set_member(&"status", v)

var latitude : float:
	get: return get_member(&"latitude")
	set(v): set_member(&"latitude", v)

var longitude : float:
	get: return get_member(&"longitude")
	set(v): set_member(&"longitude", v)

var altitude : float:
	get: return get_member(&"altitude")
	set(v): set_member(&"altitude", v)

var track : float:
	get: return get_member(&"track")
	set(v): set_member(&"track", v)

var speed : float:
	get: return get_member(&"speed")
	set(v): set_member(&"speed", v)

var climb : float:
	get: return get_member(&"climb")
	set(v): set_member(&"climb", v)

var pitch : float:
	get: return get_member(&"pitch")
	set(v): set_member(&"pitch", v)

var roll : float:
	get: return get_member(&"roll")
	set(v): set_member(&"roll", v)

var dip : float:
	get: return get_member(&"dip")
	set(v): set_member(&"dip", v)

var time : float:
	get: return get_member(&"time")
	set(v): set_member(&"time", v)

var gdop : float:
	get: return get_member(&"gdop")
	set(v): set_member(&"gdop", v)

var pdop : float:
	get: return get_member(&"pdop")
	set(v): set_member(&"pdop", v)

var hdop : float:
	get: return get_member(&"hdop")
	set(v): set_member(&"hdop", v)

var vdop : float:
	get: return get_member(&"vdop")
	set(v): set_member(&"vdop", v)

var tdop : float:
	get: return get_member(&"tdop")
	set(v): set_member(&"tdop", v)

var err : float:
	get: return get_member(&"err")
	set(v): set_member(&"err", v)

var err_horz : float:
	get: return get_member(&"err_horz")
	set(v): set_member(&"err_horz", v)

var err_vert : float:
	get: return get_member(&"err_vert")
	set(v): set_member(&"err_vert", v)

var err_track : float:
	get: return get_member(&"err_track")
	set(v): set_member(&"err_track", v)

var err_speed : float:
	get: return get_member(&"err_speed")
	set(v): set_member(&"err_speed", v)

var err_climb : float:
	get: return get_member(&"err_climb")
	set(v): set_member(&"err_climb", v)

var err_time : float:
	get: return get_member(&"err_time")
	set(v): set_member(&"err_time", v)

var err_pitch : float:
	get: return get_member(&"err_pitch")
	set(v): set_member(&"err_pitch", v)

var err_roll : float:
	get: return get_member(&"err_roll")
	set(v): set_member(&"err_roll", v)

var err_dip : float:
	get: return get_member(&"err_dip")
	set(v): set_member(&"err_dip", v)

var position_covariance : PackedFloat64Array:
	get: return get_member(&"position_covariance")
	set(v): set_member(&"position_covariance", v)

var position_covariance_type : int:
	get: return get_member(&"position_covariance_type")
	set(v): set_member(&"position_covariance_type", v)

