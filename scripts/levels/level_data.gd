class_name LevelData extends Resource


## The size of the level. Small values may behave strangely.
@export var size: Vector2i
## The background used for the level.
@export var background: Texture2D
## An array containing all the entities and their starting positions in the level.
@export var entities: Array[EntityData]
