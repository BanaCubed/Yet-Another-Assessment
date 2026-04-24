class_name GridTile extends Control


signal selected

## The type of entity being rendered on this grid tile.
## It may be beneficial in future to move entities off the grid tile while they move.
@export var entity_type: EntityType

## Whether or not this grid tile is the one that is selected.
var is_selected := false
## The current progress of the easing of the selection animation.
var animation_progress := 0.0


func _process(delta: float) -> void:
	animation_progress += delta


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		select(event)


func select(event: InputEventMouseButton) -> void:
	if event.button_index != MouseButton.MOUSE_BUTTON_LEFT:
		return
	if not event.pressed:
		return
	get_viewport().set_input_as_handled()
	selected.emit()
	animation_progress = 0
	is_selected = true
	print("The grid tile has been clicked!")


## Deselects this grid tile.
func deselect() -> void:
	animation_progress = 0
	is_selected = false
