class_name GridTile extends Control


signal selected(coordinates: Vector2i)

## The type of entity being rendered on this grid tile.
## It may be beneficial in future to move entities off the grid tile while they move.
@export var entity_type: EntityType

## The current progress of the easing of the selection animation for panels.
var tween_panel: Tween
## The coordinates at which this grid tile is located.
var tile_coordinates := Vector2i(0, 0)


# I'm not sure why overriding _gui_input() doesn't work.
func _on_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index != MOUSE_BUTTON_LEFT:
			return
		if not event.pressed:
			return
		if $ActionIndicator.visible:
			selected.emit(tile_coordinates)
			return
		select()


#region Selection Logic
## Selects this grid tile.
func select() -> void:
	selected.emit(tile_coordinates)
	if tween_panel:
		tween_panel.kill()
	tween_panel = create_tween()
	tween_panel.set_trans(Tween.TRANS_EXPO)
	tween_panel.tween_property($Panel, ^"rotation", PI / 4.05, 0.4)


## Deselects this grid tile.
func deselect() -> void:
	if tween_panel:
		tween_panel.kill()
	tween_panel = create_tween()
	tween_panel.set_trans(Tween.TRANS_EXPO)
	tween_panel.tween_property($Panel, ^"rotation", 0.0, 0.4)


## Sets the sprite displayed in this tile's action indicator.
## Also sets it to be visible if it isn't already.
func set_action_indicator(texture: Texture2D):
	$ActionIndicator.texture = texture
	$ActionIndicator.visible = true


## Makes the action indicator invisible.
## I would make this play an animation but there's no opacity option.
func clear_action_indicator():
	$ActionIndicator.visible = false
#endregion
