class_name GridTile extends Control


signal select

## The type of entity being rendered on this grid tile.
## It may be beneficial in future to move entities off the grid tile while they move.
@export var entity_type: EntityType

## Whether or not this grid tile is the one that is selected.
var selected := false
## The current progress of the easing of the selection animation.
var animation_progress := 0.0

func _ready() -> void:
	# TODO: Find some way to detect when $Panel is clicked.
	pass

func _process(delta: float) -> void:
	animation_progress += delta

func _on_selection_button_pressed() -> void:
	select.emit()
	animation_progress = 0
	selected = true

## Deselects this grid tile.
func deselect() -> void:
	animation_progress = 0
	selected = false
