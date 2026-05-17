class_name LevelSelect extends Control
## Control node that manages the level selection process.


## Levels to be included in this level selection screen.
## Generally speaking, this is just a workaround to not being able to get all files
## inside a directory under res://.
@export var levelpack: Array[LevelData]


## The data of the selected level.
var selected_level: LevelData


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for level in levelpack:
		var entry: LevelSelectEntry = $ScrollContainer/LevelFlowContainer/LevelSelectEntry.duplicate()
		entry.visible = true
		entry.level_data = level
		$ScrollContainer/LevelFlowContainer.add_child(entry)
		level.resource_local_to_scene = true


func _on_level_select_entry_selected(data: LevelData) -> void:
	selected_level = data
	$SelectButton.visible = true
	$TitleContainer/TitleLabel.text = data.name


func _on_select_button_pressed() -> void:
	var new_scene: Level = preload("res://scenes/level.tscn").instantiate()
	new_scene.level_data = selected_level
	get_tree().change_scene_to_node(new_scene)


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))
