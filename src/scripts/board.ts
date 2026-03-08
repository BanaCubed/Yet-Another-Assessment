import type { CoordinateContainer, CoordinatePair } from './abstract';
import type { EntityTypes, GenericEntity } from './entity';

/**
 * Type of an object containing all information about a board.
 */
export interface BoardState {
	/**
	 * The current size of the board.
	 * Entities are allowed to exist beyond the borders.
	 */
	size: CoordinatePair;
	/**
	 * A reference to where entities are located, sorted by location.
	 * There is no confirmation that any entities exist as both actual data and a reference,
	 * which could prove to be a problem.
	 */
	cellData: CoordinateContainer<BoardCellEntityReference[]>;
	/**
	 * An "array" of all the different entities loaded in the current board.
	 * Each type of entity exists seperately, which should help avoid issues when
	 * entities are added or removed.
	 *
	 * Type annotation refers to key as a number, but it should be treated as {@link EntityTypes}
	 */
	entityData: Record<number, GenericEntity[]>;
}

/**
 * Type of an object containing a reference to an entity's internal location.
 *
 * No actual information about the entity's properties is stored beyond its type.
 */
export interface BoardCellEntityReference {
	/** The type of entity. */
	type: EntityTypes;
	/** The location of the referenced entity. */
	loc: number;
}
