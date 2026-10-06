extends MarginContainer

var miku =  null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _miku_truco() -> void:
	if miku == null:
		var miku_scene = preload("res://Assets/secret/super_secret/source/miku_lp.tscn")
		miku = miku_scene.instantiate()
		Sim.car.add_child(miku)
		miku.position = Vector3(0, -0.3, 0.525)
	else:
		Sim.car.remove_child(miku)
		miku.queue_free()
		miku = null
