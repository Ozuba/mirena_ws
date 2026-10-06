extends RosMsg
class_name RosTestMsgsStrings

func _init():
	init("test_msgs/msg/Strings")

var string_value : String:
	get: return get_member(&"string_value")
	set(v): set_member(&"string_value", v)

var string_value_default1 : String:
	get: return get_member(&"string_value_default1")
	set(v): set_member(&"string_value_default1", v)

var string_value_default2 : String:
	get: return get_member(&"string_value_default2")
	set(v): set_member(&"string_value_default2", v)

var string_value_default3 : String:
	get: return get_member(&"string_value_default3")
	set(v): set_member(&"string_value_default3", v)

var string_value_default4 : String:
	get: return get_member(&"string_value_default4")
	set(v): set_member(&"string_value_default4", v)

var string_value_default5 : String:
	get: return get_member(&"string_value_default5")
	set(v): set_member(&"string_value_default5", v)

var bounded_string_value : String:
	get: return get_member(&"bounded_string_value")
	set(v): set_member(&"bounded_string_value", v)

var bounded_string_value_default1 : String:
	get: return get_member(&"bounded_string_value_default1")
	set(v): set_member(&"bounded_string_value_default1", v)

var bounded_string_value_default2 : String:
	get: return get_member(&"bounded_string_value_default2")
	set(v): set_member(&"bounded_string_value_default2", v)

var bounded_string_value_default3 : String:
	get: return get_member(&"bounded_string_value_default3")
	set(v): set_member(&"bounded_string_value_default3", v)

var bounded_string_value_default4 : String:
	get: return get_member(&"bounded_string_value_default4")
	set(v): set_member(&"bounded_string_value_default4", v)

var bounded_string_value_default5 : String:
	get: return get_member(&"bounded_string_value_default5")
	set(v): set_member(&"bounded_string_value_default5", v)

