extends PanelContainer


signal dismissed


func _on_button_pressed() -> void:
	dismissed.emit()
