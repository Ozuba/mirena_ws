extends RosMsg
class_name RosSimulationInterfacesSpawnEntity

func _init():
	init("simulation_interfaces/msg/SpawnEntity")

var name : String:
	get: return get_member(&"name")
	set(v): set_member(&"name", v)

var allow_renaming : bool:
	get: return get_member(&"allow_renaming")
	set(v): set_member(&"allow_renaming", v)

var entity_resource : RosSimulationInterfacesResource:
	get: return get_member(&"entity_resource") as RosMsg
	set(v): set_member(&"entity_resource", v)

var entity_namespace : String:
	get: return get_member(&"entity_namespace")
	set(v): set_member(&"entity_namespace", v)

var initial_pose : RosGeometryMsgsPoseStamped:
	get: return get_member(&"initial_pose") as RosMsg
	set(v): set_member(&"initial_pose", v)

