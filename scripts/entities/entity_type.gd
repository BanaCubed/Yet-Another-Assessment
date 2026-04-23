class_name EntityType extends Resource

## The name of this entity type. Used for interactions from other entities.
@export var name: StringName
## Texture used to render this entity type.
@export var sprite: Texture2D

@export_group("Interactions")
## Rules for this entity's interactions with other entities.
@export var entity_interactions: Array
## Rules for this entity's interactions with different terrain types.
@export var terrain_interactions: Array

@export_group("Movement")
## Total budget for this entity's movement in a single turn.
@export var movement_points: int
## Rules that define how this entity can move around the grid.
@export var movement_rules: Array
