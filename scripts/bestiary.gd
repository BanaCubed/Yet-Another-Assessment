class_name Bestiary extends Control
## Control node containing the details for the bestiary.


## The types of entities in the current level that should be shown within the bestiary.
var entity_types: Array[EntityType]


func _ready() -> void:
	var types_names: Array[StringName] = []
	for type in entity_types:
		types_names.append(type.name)
	
	for entity in entity_types:
		var new_entry: BestiaryEntry = $ScrollContainer/VBoxContainer/BestiaryEntry.duplicate()
		new_entry.level_types_names = types_names
		new_entry.entity_type = entity

		new_entry.visible = true
		$ScrollContainer/VBoxContainer.add_child(new_entry)
