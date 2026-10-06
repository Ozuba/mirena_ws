extends RosMsg
class_name RosSimulationInterfacesSpawnResult

func _init():
	init("simulation_interfaces/msg/SpawnResult")

var result : RosSimulationInterfacesResult:
	get: return get_member(&"result") as RosMsg
	set(v): set_member(&"result", v)

var entity_name : String:
	get: return get_member(&"entity_name")
	set(v): set_member(&"entity_name", v)

