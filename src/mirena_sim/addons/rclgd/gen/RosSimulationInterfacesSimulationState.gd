extends RosMsg
class_name RosSimulationInterfacesSimulationState

func _init():
	init("simulation_interfaces/msg/SimulationState")

var state : int:
	get: return get_member(&"state")
	set(v): set_member(&"state", v)

