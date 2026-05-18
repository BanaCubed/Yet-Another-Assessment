class_name BestiaryInteraction extends HBoxContainer
## Control node containing the details for an interaction's entry in the bestiary.


@export var interaction: Interaction


func _ready() -> void:
	$TargetLabel.text = interaction.target_type
	$TypeLabel.text = Interaction.name_of_interaction(interaction.interaction_type)
