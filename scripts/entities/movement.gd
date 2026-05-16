class_name Movement extends Object
## Generic class ussed more as a namespace to contain movement-related functions.


## Enum of all movement types accepted.
enum MovementType {
	## Disables movement.
	STATIONARY,
	## Can move infinitely horizontally *or* vertically, until hitting another entity.
	ORTHOGONAL,
	## Can move infinitely diagonally until hitting another entity.
	DIAGONAL,
	## Can move suspiciously like a knight from hit game Chess™.
	HORSE,
}


#region Vector Constants
## Constant containing the offset vectors of the HORSE movement type.
const HORSE_VECTORS: Array[Vector2i] = [
	Vector2i(-1, -2),
	Vector2i(-2, -1),
	Vector2i(1, -2),
	Vector2i(2, -1),
	Vector2i(-1, 2),
	Vector2i(-2, 1),
	Vector2i(1, 2),
	Vector2i(2, 1),
]


## Constant containing the movement vectors of the ORTHOGONAL movement type.
const ORTHOGONAL_VECTORS: Array[Vector2i] = [
	Vector2i(0, 1),
	Vector2i(0, -1),
	Vector2i(1, 0),
	Vector2i(-1, 0),
]


## Constant containing the movement vectors of the DIAGONAL movement type.
const DIAGONAL_VECTORS: Array[Vector2i] = [
	Vector2i(1, 1),
	Vector2i(1, -1),
	Vector2i(-1, 1),
	Vector2i(-1, -1),
]
#endregion


#region Valid Tiles
## Collects the valid tiles that an entity would be able to go to.
## Currently does not support walls of any kind.
static func get_valid_tiles(
	type: MovementType,
	grid_size: Vector2i,
	origin: Vector2i,
	wall_tiles: Array[Vector2i],
	blocked_tiles: Array[Vector2i],
) -> Array[Vector2i]:
	var tiles_collector: Array[Vector2i] = []
	match type:
		MovementType.ORTHOGONAL:
			for VECTOR in ORTHOGONAL_VECTORS:
				var to_check = origin + VECTOR
				while (
					to_check.x < grid_size.x and
					to_check.x >= 0 and
					to_check.y < grid_size.y and
					to_check.y >= 0 and
					to_check not in wall_tiles
				):
					if to_check not in blocked_tiles:
						tiles_collector.append(to_check)
					to_check += VECTOR
		MovementType.DIAGONAL:
			for VECTOR in DIAGONAL_VECTORS:
				var to_check = origin + VECTOR
				while (
					to_check.x < grid_size.x and
					to_check.x >= 0 and
					to_check.y < grid_size.y and
					to_check.y >= 0 and
					to_check not in wall_tiles
				):
					if to_check not in blocked_tiles:
						tiles_collector.append(to_check)
					to_check += VECTOR
		MovementType.HORSE:
			for VECTOR in HORSE_VECTORS:
				var to_check = VECTOR + origin
				if (
					to_check.x < grid_size.x and
					to_check.x >= 0 and
					to_check.y < grid_size.y and
					to_check.y >= 0 and
					to_check not in wall_tiles
				):
					if to_check not in blocked_tiles:
						tiles_collector.append(to_check)
	return tiles_collector
#endregion


#region Tile Categorizer
## Collects all the tiles considered walls through interactions.
static func find_wall_tiles(moving: EntityData, entities: Array[EntityData]) -> Array[Vector2i]:
	var collector: Array[Vector2i] = []
	for entity in entities:
		if (
			Interaction.Outcomes.ACT_AS_WALL in
			Interaction.interactions_between(moving.type, entity.type.name)
		):
			collector.append(entity.position)
	return collector


## Collects all the tiles considered blocking through interactions.
static func find_blocking_tiles(moving: EntityData, entities: Array[EntityData]) -> Array[Vector2i]:
	var collector: Array[Vector2i] = []
	for entity in entities:
		if not (
			# This is a very brute-force way to do things but should work fine.
			(
				Interaction.Outcomes.CONSUME_TARGET in
				Interaction.interactions_between(moving.type, entity.type.name) and
				entity.state != Entity.States.SPOILED
			) or
			(
				Interaction.Outcomes.CONSUME_SELF in
				Interaction.interactions_between(moving.type, entity.type.name) and
				moving.state != Entity.States.SPOILED
				
			)
		):
			collector.append(entity.position)
	return collector
#endregion
