class_name GridTile extends Control


signal selected

## The type of entity being rendered on this grid tile.
## It may be beneficial in future to move entities off the grid tile while they move.
@export var entity_type: EntityType

## Whether or not this grid tile is the one that is selected.
var is_selected := false
## The current progress of the easing of the selection animation.
var tween: Tween


func select() -> void:
	selected.emit()
	is_selected = true
	print("The grid tile has been clicked!")
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property($Panel, ^"rotation", PI / 4.05, 0.4)


## Deselects this grid tile.
func deselect() -> void:
	is_selected = false


# I'm not sure why overriding _gui_input() doesn't work.
func _on_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index != MOUSE_BUTTON_LEFT:
			return
		if not event.pressed:
			return
		select()
