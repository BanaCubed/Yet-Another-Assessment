class_name MainMenu extends Control
## Control node specifically for the main menu.
## Has little special funtionality besides connecting signals from the main menu buttons.


## Emitted when the play button in the main menu is selected.
signal play_chosen


func _on_exit_button_pressed() -> void:
	# Godot recommends using get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST),
	# but that doesn't seem to work.
	get_tree().quit()


func _on_play_button_pressed() -> void:
	play_chosen.emit()
