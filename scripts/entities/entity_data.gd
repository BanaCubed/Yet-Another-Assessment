class_name EntityData extends Resource
## Resource containing the information regarding a specific instance of an entity.


## The type of entity that this entity is.
@export var entity: EntityType
## The position of the entity on the level.
## (0,0) is the top-left corner of the level.
@export var position: Vector2i
## The current state of this entity.
@export var state := Entity.States.STATELESS
