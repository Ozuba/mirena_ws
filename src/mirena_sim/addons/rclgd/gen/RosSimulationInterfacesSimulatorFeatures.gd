extends RosMsg
class_name RosSimulationInterfacesSimulatorFeatures

func _init():
	init("simulation_interfaces/msg/SimulatorFeatures")

var features : Array:
	get: return get_member(&"features")
	set(v): set_member(&"features", v)

var spawn_formats : PackedStringArray:
	get: return get_member(&"spawn_formats")
	set(v): set_member(&"spawn_formats", v)

var custom_info : String:
	get: return get_member(&"custom_info")
	set(v): set_member(&"custom_info", v)

