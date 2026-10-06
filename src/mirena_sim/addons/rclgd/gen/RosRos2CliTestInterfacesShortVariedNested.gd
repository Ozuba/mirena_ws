extends RosMsg
class_name RosRos2CliTestInterfacesShortVariedNested

func _init():
	init("ros2cli_test_interfaces/msg/ShortVariedNested")

var short_varied : RosRos2CliTestInterfacesShortVaried:
	get: return get_member(&"short_varied") as RosMsg
	set(v): set_member(&"short_varied", v)

