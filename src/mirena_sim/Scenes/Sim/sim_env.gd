extends Node


func _ready() -> void:
	#Avoids self registration pattern
	Sim.car = $Car
	Sim.track = $Track
