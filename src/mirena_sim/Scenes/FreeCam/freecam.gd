extends Camera3D

## Camera with flying script attached to it.
class_name Freecam3D

## Customize your own toggle key to avoid collisions with your current mappings.
@export var toggle_key: Key = KEY_TAB
var _focused = true
## Speed up / down by scrolling the mouse whell down / up
@export var invert_speed_controls: bool = false

@export var overlay_text: bool = true

## Pivot node for camera looking around
@onready var pivot := Node3D.new()


const MAX_SPEED := 4
const MIN_SPEED := 0.05
const ACCELERATION := 0.1
const MOUSE_SENSITIVITY := 0.002

## The current maximum speed. Lower or higher it by scrolling the mouse wheel.
var target_speed := MIN_SPEED
## Movement velocity.
var velocity := Vector3.ZERO


## Sets up pivot and UI overlay elements.
func _setup_nodes() -> void:
	self.add_sibling(pivot)
	pivot.position = position
	pivot.rotation = rotation
	pivot.name = "FreecamPivot"
	self.reparent(pivot)
	self.position = Vector3.ZERO
	self.rotation = Vector3.ZERO
	


func _ready() -> void:
	_setup_nodes.call_deferred()
	_add_keybindings()
	# Register in Sim
	Sim.register_camera.call_deferred(self)



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("__debug_camera_toggle"):
		_focused = not _focused
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if current and _focused else Input.MOUSE_MODE_VISIBLE)
	if current and _focused:
		var dir = Vector3.ZERO
		if Input.is_action_pressed("__debug_camera_forward"): 	dir.z -= 1
		if Input.is_action_pressed("__debug_camera_back"): 		dir.z += 1
		if Input.is_action_pressed("__debug_camera_left"): 		dir.x -= 1
		if Input.is_action_pressed("__debug_camera_right"): 	dir.x += 1
		if Input.is_action_pressed("__debug_camera_up"): 		dir.y += 1
		if Input.is_action_pressed("__debug_camera_down"): 		dir.y -= 1
		
		dir = dir.normalized()
		dir = dir.rotated(Vector3.UP, pivot.rotation.y)
		
		velocity = lerp(velocity, dir * target_speed, ACCELERATION)
		pivot.position += velocity


func _input(event: InputEvent) -> void:
	if current and _focused:
		# Turn around
		if event is InputEventMouseMotion:
			pivot.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
			rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
			rotation.x = clamp(rotation.x, -PI/2, PI/2)
		
		var speed_up = func():
			target_speed = clamp(target_speed + 0.15, MIN_SPEED, MAX_SPEED)
			print("[Speed up] " + str(target_speed))
			
		var slow_down = func():
			target_speed = clamp(target_speed - 0.15, MIN_SPEED, MAX_SPEED)
			print("[Slow down] " + str(target_speed))
		
		# Speed up and down with the mouse wheel
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
				slow_down.call() if invert_speed_controls else speed_up.call()
				
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
				speed_up.call() if invert_speed_controls else slow_down.call()





func _make_label(text: String) -> Label:
	var l = Label.new()
	l.text = text
	return l


func _add_keybindings() -> void:
	var actions = InputMap.get_actions()
	if "__debug_camera_forward" not in actions: _add_key_input_action("__debug_camera_forward", KEY_W)
	if "__debug_camera_back" 	not in actions: _add_key_input_action("__debug_camera_back", KEY_S)
	if "__debug_camera_left" 	not in actions: _add_key_input_action("__debug_camera_left", KEY_A)
	if "__debug_camera_right" 	not in actions: _add_key_input_action("__debug_camera_right", KEY_D)
	if "__debug_camera_up" 		not in actions: _add_key_input_action("__debug_camera_up", KEY_SPACE)
	if "__debug_camera_down" 	not in actions: _add_key_input_action("__debug_camera_down", KEY_SHIFT)
	if "__debug_camera_toggle" 	not in actions: _add_key_input_action("__debug_camera_toggle", toggle_key)


func _add_key_input_action(name: String, key: Key) -> void:
	var ev = InputEventKey.new()
	ev.physical_keycode = key
	
	InputMap.add_action(name)
	InputMap.action_add_event(name, ev)
