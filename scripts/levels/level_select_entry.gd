class_name LevelSelectEntry extends Control
## Control node specifically for entries in the level selection menu.


## Triggered when this level is selected within the level select screen.
signal selected(data: LevelData)


## Data for the level this entry corresponds to.
@export var level_data: LevelData


## Tween variable for the panel node.
var tween_panel: Tween


func _ready() -> void:
	if level_data:
		$Icon.texture = level_data.sprite


func _on_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index != MOUSE_BUTTON_LEFT:
			return
		if not event.pressed:
			return
		select()


## Selects this level within the level select screen.
func select() -> void:
	if tween_panel:
		tween_panel.kill()
	tween_panel = create_tween()
	tween_panel.set_trans(Tween.TRANS_EXPO)
	tween_panel.tween_property($Panel, ^"rotation", PI / 4.05, 0.4)

	selected.emit(level_data)

## Deselects this level within the level select screen.
func deselect() -> void:
	if tween_panel:
		tween_panel.kill()
	tween_panel = create_tween()
	tween_panel.set_trans(Tween.TRANS_EXPO)
	tween_panel.tween_property($Panel, ^"rotation", 0.0, 0.4)
