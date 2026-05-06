class_name Movement extends Object


## Enum of all movement types accepted.
enum MovementType {
	STATIONARY,
	ORTHOGONAL,
	DIAGONAL,
	HORSE,
}

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


## Collects the valid tiles that an entity would be able to go to.
## Currently does not support walls of any kind.
static func get_valid_tiles(
		type: MovementType,
		grid_size: Vector2i,
		origin: Vector2i,
		off_limits: Array[Vector2i],
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
						to_check not in off_limits
				):
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
						to_check not in off_limits
				):
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
						to_check not in off_limits
				):
					tiles_collector.append(to_check)
			
	return tiles_collector
