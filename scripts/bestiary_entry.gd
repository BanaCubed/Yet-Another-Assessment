class_name BestiaryEntry extends HFlowContainer
## Control node containing information and functionality for an entry in the bestiary.


## The type of entity this entry represents.
@export var entity_type: EntityType


## Array of the names of other types of entities in the current level.
var level_types_names: Array[StringName]


func _ready() -> void:
	$SpriteTexture.texture = entity_type.sprite
	$InteractionBox/DescriptionLabel.text = entity_type.description
	$NameLabel.text = entity_type.name

	var interactions: Array[Interaction] = []
	for inter in entity_type.interactions:
		if inter.target_type in level_types_names:
			interactions.append(inter)
	
	for inter in interactions:
		var new_entry: BestiaryInteraction = $InteractionBox/BestiaryInteraction.duplicate()
		new_entry.interaction = inter
		new_entry.visible = true
		$InteractionBox.add_child(new_entry)
