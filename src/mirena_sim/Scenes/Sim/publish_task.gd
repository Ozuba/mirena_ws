extends RefCounted
class_name PublishTask

var name: String
var interval: float
var timer: float = 0.0
var enabled: bool = true
var callback: Callable
var publisher: RosPublisher

func _init(_name: String, _hz: float, _pub: RosPublisher, _callback: Callable):
	name = _name
	set_freq(_hz)
	publisher = _pub
	callback = _callback

func tick(delta: float):
	if(!enabled): 
		return
	
	timer += delta
	if timer >= interval:
		timer = 0.0
		callback.call(publisher) # Pasamos el publisher al callback directamente
		
func set_enabled(value: bool) -> void:
	enabled = value

func is_enabled() -> bool:
	return enabled

func get_freq() -> float:
	return 1/interval

func set_freq(freq: float) -> void:
	interval = 1.0 / freq if freq > 0 else 1000000.0 # Evitar división por cero
