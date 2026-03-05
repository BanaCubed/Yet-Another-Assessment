import type { CoordinateContainer, CoordinatePair } from './abstract';
import type { EntityTypes } from './entity';

/**
 * Type of an object containing all information about a board.
 */
export interface BoardState {
	/**
	 * The current size of the board.
	 * Entities are allowed to exist beyond the borders, but not terrain.
	 */
	size: CoordinatePair;
	cellData: CoordinateContainer<BoardCellEntityReference[]>;
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
