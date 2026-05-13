class_name EntityData extends Resource
## Resource containing the information regarding a specific instance of an type.


## The type of type that this type is.
@export var type: EntityType
## The position of the type on the level.
## (0,0) is the top-left corner of the level.
@export var position: Vector2i
## The current state of this type.
@export var state := Entity.States.STATELESS
