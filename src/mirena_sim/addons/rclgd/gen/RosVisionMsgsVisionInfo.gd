extends RosMsg
class_name RosVisionMsgsVisionInfo

func _init():
	init("vision_msgs/msg/VisionInfo")

var header : RosStdMsgsHeader:
	get: return get_member(&"header") as RosMsg
	set(v): set_member(&"header", v)

var method : String:
	get: return get_member(&"method")
	set(v): set_member(&"method", v)

var database_location : String:
	get: return get_member(&"database_location")
	set(v): set_member(&"database_location", v)

var database_version : int:
	get: return get_member(&"database_version")
	set(v): set_member(&"database_version", v)

