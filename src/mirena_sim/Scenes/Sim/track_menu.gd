extends Control

@onready var track_stats: Label = $HBoxContainer/VBoxContainer/TrackStats


func _ready():
	pass


func _on_generate_track():
	Sim.track.create_track()
	track_stats.text = _describe(Sim.track.track_gen.last_stats)


## What the generator produced, against the rules it was held to.
##
## Not a pass or a fail: the generator never returns a layout that breaks a rule,
## so this is how much room the track left. A lap sitting on 200 m with the
## tightest corner near the limit is a hard track. The fallback line means the
## noise gave up and the circle was used instead.
func _describe(stats: Dictionary) -> String:
	if stats.is_empty():
		return "No track generated"
	if stats.get("fallback", false):
		return "Fallback circle: the noise produced nothing legal"

	return "Lap %.0f m (rules %.0f-%.0f)\nTightest turn %.1f m radius (min %.1f)\nLongest straight %.0f m (max %.0f)\n%d attempt(s)" % [
		stats["lap_length"], TrackGenerator.MIN_LAP_LENGTH, TrackGenerator.MAX_LAP_LENGTH,
		stats["min_turn_radius"], TrackGenerator.MIN_TURN_RADIUS,
		stats["longest_straight"], TrackGenerator.MAX_STRAIGHT_LENGTH,
		stats.get("attempts", 0)]


func _on_open_track_pressed():
	$FileDialog.visible = true


func _on_export_track_pressed():
	$ExportDialog.visible = true


func _on_export_file_selected(path: String):
	if Sim.track.export_track(path):
		track_stats.text = "Exported to %s" % path.get_file()
	else:
		track_stats.text = "Could not write %s" % path.get_file()


func _on_track_file_selected(path: String):
	Sim.track.load_track(path)
	track_stats.text = "Loaded %s" % path.get_file()


func _on_enable_cone_collision_toggled(toggled_on: bool) -> void:
	Sim.car.cone_collision_set(toggled_on)


func _on_clear_track_pressed() -> void:
	Sim.track.clear_track()
	track_stats.text = "No track generated"
