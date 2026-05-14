class_name Entity extends Control
## Control node representing an entity.
## Automatically updates itself based on the entity_type property.


## Enum containing the states that an entity can be in.
enum States {
	## Disables rendering of the state display text, since it should be irrelevant.
	STATELESS = 0,
	## An animal that has not yet eaten a valid food type.
	HUNGRY = 1,
	## An animal that has eaten food.
	SATIATED = 2,
	## Food that has spoiled.
	SPOILED = 3,
	## An entity that has been removed and will be deleted on the next frame.
	REMOVED = 4,
	## For food that has been preserved and will not spoil.
	PRESERVED = 5,
	
	# -- Negative values represent turns until a food entity spoils.
	SPOILS_IN_1 = -1,
	SPOILS_IN_2 = -2,
	SPOILS_IN_3 = -3,
}


## The type of entity to render.
@export var entity_type: EntityType
## The state of this entity.
@export var entity_state: States


#region Name from State
## Converts the enum values into strings representing the state of an entity.
## This function should probably be in a different file but I cannot think of where else it could go.
static func name_from_state_id(id: States) -> String:
	match id:
		States.HUNGRY:
			return "HUNGRY"
		States.SATIATED:
			return "SATIATED"
		States.SPOILED:
			return "ROTTEN"
		States.REMOVED:
			return "PENDING DELETION"
		States.PRESERVED:
			return "PRESERVED"
		States.SPOILS_IN_1:
			return "SPOILS IN: 1 MOVE"
		States.SPOILS_IN_2:
			return "SPOILS IN: 2 MOVES"
		States.SPOILS_IN_3:
			return "SPOILS IN: 3 MOVES"
		_:
			return ""
#endregion


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$EntitySprite.texture = entity_type.sprite
