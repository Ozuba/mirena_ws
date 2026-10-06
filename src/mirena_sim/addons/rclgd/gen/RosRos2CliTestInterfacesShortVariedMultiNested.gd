extends RosMsg
class_name RosRos2CliTestInterfacesShortVariedMultiNested

func _init():
	init("ros2cli_test_interfaces/msg/ShortVariedMultiNested")

var short_varied_nested : RosRos2CliTestInterfacesShortVariedNested:
	get: return get_member(&"short_varied_nested") as RosMsg
	set(v): set_member(&"short_varied_nested", v)

