class_name LevelData extends Resource
## Resource containing all the information stored for a level.


## The dimensions of the level. Small values may behave strangely.
@export var dimensions: Vector2i
## The background used for the level.
@export var background: Texture2D
## An array containing all the entities and their starting positions in the level.
@export var entities: Array[EntityData]


@export_group("Level Select")
## The name of this level.
@export var name: StringName
## The index of this level.
@export var number: int
## The sprite used to render this level in the level selection screen.
@export var sprite: Texture2D
