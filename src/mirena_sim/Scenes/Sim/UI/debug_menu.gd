extends MarginContainer

@onready var config_panel := $VBoxContainer/ConfigPanel
@onready var pub_selector := $VBoxContainer/HBoxContainer/OptionButton
@onready var enable_button := $VBoxContainer/ConfigPanel/MarginContainer/VBoxContainer/EnableContainer/CheckButton
@onready var frequency_linedit := $VBoxContainer/ConfigPanel/MarginContainer/VBoxContainer/FrequencyContainer/LineEdit
@onready var frequency_linedit_commit := $VBoxContainer/ConfigPanel/MarginContainer/VBoxContainer/FrequencyContainer/Button


var publishers: Dictionary[int, PublishTask] 
var index_counter := 0

func _ready() -> void:
	pub_selector.item_selected.connect(_on_pub_selected)
	enable_button.toggled.connect(_on_enable_toggled)
	frequency_linedit_commit.pressed.connect(_on_frequency_commit)
	
	pub_selector.add_item("[Select]", 0)

func register_publisher(pub: PublishTask) -> void:
	index_counter += 1
	publishers.set(index_counter, pub)
	pub_selector.add_item(pub.name, index_counter)

func _on_pub_selected(index: int) -> void:
	if (index == 0):
		config_panel.hide()
	else:
		config_panel.show()
		_update()

func _on_enable_toggled(value: bool) -> void:
	if pub_selector.get_selected_id() == 0:
		return
		
	var pub : PublishTask = publishers.get(pub_selector.get_selected_id())
	pub.set_enabled(value)
	_update()

func _on_frequency_commit() -> void:
	if pub_selector.get_selected_id() == 0:
		return
		
	var pub : PublishTask = publishers.get(pub_selector.get_selected_id())
	var freq_str : String = frequency_linedit.text
	if not freq_str.is_valid_float():
		get_tree().quit(69) # Ozuba reañade el puto MirenaLogger
	var freq = float(freq_str)
	if freq < 5 or freq > 120:
		get_tree().quit(69) # Ozuba reañade el puto MirenaLogger
	pub.set_freq(freq)
	_update()
	
func _update() -> void:
	if pub_selector.get_selected_id() == 0:
		return
		
	var pub : PublishTask = publishers.get(pub_selector.get_selected_id())
	enable_button.set_pressed_no_signal(pub.is_enabled())
	frequency_linedit.text = str(pub.get_freq())
