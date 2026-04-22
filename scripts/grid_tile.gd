extends Panel


signal select

var selected := false

func _ready() -> void:
	$SelectionButton.pressed.connect(select.emit)
