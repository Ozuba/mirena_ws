extends Node

static func _static_init() -> void:
	if Engine.is_editor_hint(): return
	if rclgd:
		rclgd.init(OS.get_cmdline_args())
		print("[ROS Init Args]: ",OS.get_cmdline_args())
		

func _exit_tree() -> void:
	if rclgd and rclgd.ok():
		rclgd.shutdown()
		print("[ROS] Shutdown called from exit_tree.")
