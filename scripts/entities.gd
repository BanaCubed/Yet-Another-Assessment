class_name Entities
extends Node
## Static object thingy that contains the currently loaded entities.

static var entities: Array[Sprite2D] = []

static func entities_on_tile() -> Array[Sprite2D]:
	var _entities = []
	return _entities

static func create_entity(entity: EntityData):
	var _node = Sprite2D.new()
	pass

## An abstract class representing the values expected to be passed when creating an entity.
@abstract class EntityData:
	var x_coordinate: int
	var y_coordinate: int
