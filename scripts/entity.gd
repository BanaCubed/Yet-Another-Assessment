class_name Entity extends Control
## Control node representing an entity.
## Automatically updates itself based on the entity_type property.


## Enum containing the states that an entity can be in.
enum States {
	STATELESS = 0,
	HUNGRY = 1,
	SATIATED = 2,
	SPOILED = 3,
	SPOILS_IN_1 = -1,
	SPOILS_IN_2 = -2,
	SPOILS_IN_3 = -3,
}


## The type of entity to render.
@export var entity_type: EntityType


static func name_from_state_id(id: States) -> String:
	match id:
		States.HUNGRY:
			return "HUNGRY"
		States.SATIATED:
			return "SATIATED"
		States.SPOILED:
			return "ROTTEN"
		States.SPOILS_IN_1:
			return "SPOILS IN: 1 MOVE"
		States.SPOILS_IN_2:
			return "SPOILS IN: 2 MOVES"
		States.SPOILS_IN_3:
			return "SPOILS IN: 3 MOVES"
		_:
			return ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$EntitySprite.texture = entity_type.sprite
