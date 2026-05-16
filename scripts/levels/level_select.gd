class_name LevelSelect extends Control
## Control node that manages the level selection process.


## Emitted when a level is selected in the menu.
signal level_selected(data: LevelData)


## Levels to be included in this level selection screen.
## Generally speaking, this is just a workaround to not being able to get all files
## inside a directory under res://.
@export var levelpack: Array[LevelData]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for level in levelpack:
		var entry: LevelSelectEntry = $ScrollContainer/LevelFlowContainer/LevelSelectEntry.duplicate()
		entry.visible = true
		entry.level_data = level
		$ScrollContainer/LevelFlowContainer.add_child(entry)


func _on_level_select_entry_selected(data: LevelData) -> void:
	level_selected.emit(data)
