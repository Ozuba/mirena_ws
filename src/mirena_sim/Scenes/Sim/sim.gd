extends Node

# -------------------------------------------------
# Global objects
# -------------------------------------------------

var _stats: Dictionary = {
	"cones_fallen": 0
}


var car : MirenaCar
var track : Track
var arguments : Dictionary


# -------------------------------------------------
# Runtime
# -------------------------------------------------


func _ready() -> void:	
	self._parse_arguments()

	
func _input(event):
	# Camera Toggle
	if event.is_action_pressed("alternate_camera"):
		# The manager handles the internal index math (modulo, bounds checking)
		cycle_camera()
		
		# Optional: Print the name of the node for debugging
		var active = get_active_camera()
		if active:
			print("Switched to camera: ", active.name)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("Ctrl+C or Close detected. Shutting down...")
		# Perform cleanup here (save files, close sockets, etc.)
		get_tree().quit()

# -------------------------------------------------
# Argument Parser
# -------------------------------------------------

func _parse_arguments() -> void:
	var arguments = {}
	#Process user messages
	for argument in OS.get_cmdline_args():
		if argument.contains("="):
			var key_value = argument.split("=")
			arguments[key_value[0].trim_prefix("--")] = key_value[1]
		else:
			# Options without an argument will be present in the dictionary,
			# with the value set to an empty string.
			arguments[argument.trim_prefix("--")] = ""
	self.arguments = arguments
	print(arguments)

	#else:
		
	# Hndle custom track load
	#if arguments.has("track"):
	#	SIM.get_env().get_track_manager().loadTrack(arguments["track"])
	#if arguments.has("follow"):
	#	SIM.get_vehicle().follow_path($Track.path)

	
# -------------------------------------------------
# Camera management
# -------------------------------------------------

# Dictionary to store cameras by a unique String ID
var _cameras: Array[Camera3D] = []
var _active_index: int = -1

## Just pass the camera. No ID needed.
func register_camera(camera: Camera3D):
	if not _cameras.has(camera):
		_cameras.append(camera)
		
		# AUTOMATION: When the camera is deleted, it cleans itself up
		camera.tree_exiting.connect(func(): unregister_camera(camera))
		
		if _cameras.size() == 1:
			switch_to_index(0)

func unregister_camera(camera: Camera3D):
	var idx = _cameras.find(camera)
	if idx != -1:
		_cameras.remove_at(idx)
		# If we removed the active camera, snap to the previous valid one
		if _active_index == idx:
			_active_index = posmod(_active_index - 1, max(1, _cameras.size()))
			_update_camera_states()

## Cycle to the next camera in the order they were added
func cycle_camera():
	if _cameras.is_empty(): return
	var next_idx = (_active_index + 1) % _cameras.size()
	switch_to_index(next_idx)

func switch_to_index(idx: int):
	if idx < 0 or idx >= _cameras.size(): return
	_active_index = idx
	_update_camera_states()

func _update_camera_states():
	for i in _cameras.size():
		if is_instance_valid(_cameras[i]):
			_cameras[i].current = (i == _active_index)

## Helper to get the currently active camera object
func get_active_camera() -> Camera3D:
	if _active_index != -1 and _active_index < _cameras.size():
		return _cameras[_active_index]
	return null
