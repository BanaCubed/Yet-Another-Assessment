import type { CoordinateContainer, CoordinatePair } from './abstract';
import type { GenericEntity } from './entities/generic';
import type EntityTypes from './entities/generic';

/**
 * Type of an object containing all information about a board.
 */
export class BoardState {
	/**
	 * The current size of the board.
	 * Entities are allowed to exist beyond the borders.
	 */
	public size: CoordinatePair;

	/**
	 * A reference to where entities are located, sorted by location.
	 * There is no confirmation that any entities exist as both actual data and a reference,
	 * which could prove to be a problem.
	 */
	public cellData: CoordinateContainer<BoardCellEntityReference[]> = [];

	/**
	 * An "array" of all the different entities loaded in the current board.
	 * Each type of entity exists seperately, which should help avoid issues when
	 * entities are added or removed.
	 *
	 * Type annotation refers to key as a number, but it should be treated as {@link EntityTypes}
	 */
	public entityData: Partial<Record<EntityTypes, Array<GenericEntity | undefined>>> = {};

	constructor(size: CoordinatePair) {
		this.size = size;
	}

	/**
	 * Adds an entity to the board in both cellData and entityData.
	 */
	public addEntity(entity: GenericEntity) {
		const TYPE = entity.entityType;
		const LOC = entity.location;

		this.entityData[TYPE] ??= [];
		this.entityData[TYPE].push(entity);

		const INDEX = this.entityData[TYPE].indexOf(entity);
		const reference: BoardCellEntityReference = {
			type: TYPE,
			loc: INDEX,
		};

		this.cellData[LOC.x] ??= {};
		(this.cellData[LOC.x] as Record<number, BoardCellEntityReference[]>)[LOC.y] ??= [];
		try {
			// Using ?. here is easier that using 'as' repeatedly.
			this.cellData[LOC.x]?.[LOC.y]?.push(reference);
		} catch (error) {
			throw new Error('Failed to append entity to board cellData reference.');
		}
	}

	/**
	 * Removes an entity from the board in relevant places.
	 */
	public removeEntity(entity: GenericEntity) {
		const TYPE = entity.entityType;
		const LOC = entity.location;

		this.entityData[TYPE] ??= [];
		const edIndex = this.entityData[TYPE].indexOf(entity);

		const reference = {
			type: TYPE,
			loc: edIndex,
		};

		const cdIndex =
			this.cellData[LOC.x]?.[LOC.y]?.findIndex(
				(el) => el.type === reference.type && el.loc === reference.loc,
			) ?? 1;

		this.entityData[TYPE][edIndex] = undefined;

		if (cdIndex === -1) return; // better safe than sorry
		this.cellData[LOC.x]?.[LOC.y]?.splice(cdIndex, 1);
	}
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
