class_name Entity extends Control
## Control node representing an entity.
## Automatically updates itself based on the entity_type property.


## The type of entity to render.
@export var entity_type: EntityType


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$EntitySprite.texture = entity_type.sprite
