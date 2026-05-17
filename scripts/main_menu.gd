class_name MainMenu extends Control
## Control node specifically for the main menu.
## Has little special funtionality besides connecting signals from the main menu buttons.


func _ready() -> void:
	Persistence.init_completed()


func _on_exit_button_pressed() -> void:
	# Godot recommends using get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST),
	# but that doesn't seem to work.
	get_tree().quit()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(preload("res://scenes/level_select.tscn"))
