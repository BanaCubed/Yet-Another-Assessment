class_name EntityType extends Resource
## Resource containing all the information regarding a type of entity.


## The name of this entity type. Used for interactions from other entities.
@export var name: StringName
## Texture used to render this entity type.
@export var sprite: Texture2D
## How this entity moves around.
@export var movement_type: Movement.MovementType
## The interactions this entity has with other entities.
@export var interactions: Array[Interaction]
