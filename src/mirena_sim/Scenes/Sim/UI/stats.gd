extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	var fps = Engine.get_frames_per_second()
	$MarginContainer/VBoxContainer/FpsLabel.text = "FPS: %d" % Engine.get_frames_per_second()
