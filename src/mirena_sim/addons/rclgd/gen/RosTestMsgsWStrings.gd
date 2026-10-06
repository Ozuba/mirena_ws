extends RosMsg
class_name RosTestMsgsWStrings

func _init():
	init("test_msgs/msg/WStrings")

var wstring_value : Nil:
	get: return get_member(&"wstring_value")
	set(v): set_member(&"wstring_value", v)

var wstring_value_default1 : Nil:
	get: return get_member(&"wstring_value_default1")
	set(v): set_member(&"wstring_value_default1", v)

var wstring_value_default2 : Nil:
	get: return get_member(&"wstring_value_default2")
	set(v): set_member(&"wstring_value_default2", v)

var wstring_value_default3 : Nil:
	get: return get_member(&"wstring_value_default3")
	set(v): set_member(&"wstring_value_default3", v)

var array_of_wstrings : Array:
	get: return get_member(&"array_of_wstrings")
	set(v): set_member(&"array_of_wstrings", v)

var bounded_sequence_of_wstrings : Array:
	get: return get_member(&"bounded_sequence_of_wstrings")
	set(v): set_member(&"bounded_sequence_of_wstrings", v)

var unbounded_sequence_of_wstrings : Array:
	get: return get_member(&"unbounded_sequence_of_wstrings")
	set(v): set_member(&"unbounded_sequence_of_wstrings", v)

