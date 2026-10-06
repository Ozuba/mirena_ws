extends RosMsg
class_name RosRos2CliTestInterfacesShortVaried

func _init():
	init("ros2cli_test_interfaces/msg/ShortVaried")

var bool_value : bool:
	get: return get_member(&"bool_value")
	set(v): set_member(&"bool_value", v)

var bool_values : Array:
	get: return get_member(&"bool_values")
	set(v): set_member(&"bool_values", v)

