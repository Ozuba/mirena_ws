extends Label

func _ready() -> void:
	# Display Controls
	self.text = "Press < %s > to open menu" % get_first_key_for_action(&"open_sim_menu")
	self.text += "\nPress < %s > to switch camera" %get_first_key_for_action(&"alternate_camera")
	
func get_first_key_for_action(action: String) -> String:
	var events = InputMap.action_get_events(action)
	for event in events:
		if event is InputEventKey:
			return OS.get_keycode_string(event.physical_keycode)
	return "None"
	
