extends Control
class_name MirenaHud

@onready var fps_label: Label = $Stats/MarginContainer/VBoxContainer/FpsLabel
@onready var timer_label: Label = $Stats/MarginContainer/VBoxContainer/TimerLabel
@onready var fallen_cones_label: Label = $Stats/MarginContainer/VBoxContainer/FallenConesLabel

func _input(event):
	# Toggle Visibility
	if event.is_action_pressed("open_sim_menu"):
		visible = !visible
