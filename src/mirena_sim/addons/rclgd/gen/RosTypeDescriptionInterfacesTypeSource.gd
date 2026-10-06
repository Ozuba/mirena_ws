extends RosMsg
class_name RosTypeDescriptionInterfacesTypeSource

const ROS_TYPE_NAME = "type_description_interfaces/msg/TypeSource"

func _init():
	init(ROS_TYPE_NAME)

var type_name : String:
	get: return get_member(&"type_name")
	set(v): set_member(&"type_name", v)

var encoding : String:
	get: return get_member(&"encoding")
	set(v): set_member(&"encoding", v)

var raw_file_contents : String:
	get: return get_member(&"raw_file_contents")
	set(v): set_member(&"raw_file_contents", v)

