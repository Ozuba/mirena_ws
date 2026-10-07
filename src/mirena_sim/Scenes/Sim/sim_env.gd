extends Node


# Not _ready(): children are ready before their parent, and Track emits
# track_loaded (which resets the car to Sim.track.origin) from its own _ready().
# _enter_tree() runs parent-first, so the references exist by then.
func _enter_tree() -> void:
	#Avoids self registration pattern
	Sim.car = $Car
	Sim.track = $Track
