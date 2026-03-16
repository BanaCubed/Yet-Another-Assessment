import type { CoordinateContainer, CoordinatePair } from './abstract';
import type Entity from './entities/entity';
import type { EntityTypeID } from './entities/entity';

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
	public cellData: CoordinateContainer<EntityReference[]> = [];

	/**
	 * An "array" of all the different entities loaded in the current board.
	 * Each type of entity exists seperately, which should help avoid issues when
	 * entities are added or removed.
	 *
	 * Type annotation refers to key as a number, but it should be treated as {@link EntityTypeID}
	 */
	public entityData: Partial<Record<EntityTypeID, Array<Entity | undefined>>> = {};

	constructor(size: CoordinatePair) {
		this.size = size;
	}

	/**
	 * Adds an entity to the board in both cellData and entityData.
	 */
	public addEntity(entity: Entity) {
		const TYPE = entity.entityType;
		const LOC = entity.location;

		this.entityData[TYPE] ??= [];
		this.entityData[TYPE].push(entity);

		const ENTITY_INDEX = this.entityData[TYPE].indexOf(entity);
		const reference: EntityReference = {
			type: TYPE,
			loc: ENTITY_INDEX,
		};

		this.cellData[LOC.x] ??= {};
		(this.cellData[LOC.x] as Record<number, EntityReference[]>)[LOC.y] ??= [];
		try {
			// Using ?. here is easier that using 'as' repeatedly.
			this.cellData[LOC.x]?.[LOC.y]?.push(reference);
		} catch (error) {
			throw new Error('Failed to append entity to board cellData reference.');
		}
	}

	/**
	 * Removes an entity from the board in relevant places.
	 * @param entity The entity to remove.
	 * @todo Let the entity parameter also be a BoardCellEntityReference.
	 */
	public removeEntity(entity: Entity) {
		const TYPE = entity.entityType;
		const LOC = entity.location;

		this.entityData[TYPE] ??= [];
		const ENTITY_INDEX = this.entityData[TYPE].indexOf(entity);

		const ENTITY_REFERENCE = {
			type: TYPE,
			loc: ENTITY_INDEX,
		};

		const CELL_INDEX =
			this.cellData[LOC.x]?.[LOC.y]?.findIndex(
				(el) => el.type === ENTITY_REFERENCE.type && el.loc === ENTITY_REFERENCE.loc,
			) ?? 1;

		this.entityData[TYPE][ENTITY_INDEX] = undefined;

		if (CELL_INDEX === -1) return; // better safe than sorry
		this.cellData[LOC.x]?.[LOC.y]?.splice(CELL_INDEX, 1);
	}

	/**
	 * Gathers all the entities on a specified cell of the board's grid and returns them in an array.
	 * @param tile The tile on the board's grid to get the entities at.
	 */
	public gatherEntitiesOnTile(tile: CoordinatePair): Entity[] {
		const entityReferencesArray: EntityReference[] = this.cellData[tile.x]?.[tile.y] ?? [];

		const entityArray: Entity[] = [];
		for (let i = 0; i < entityReferencesArray.length; i++) {
			const entityReference: EntityReference = entityReferencesArray[i] as EntityReference;
			if (entityReference !== undefined) {
				entityArray.push(
					this.entityData[entityReference.type]?.[entityReference.loc] as Entity,
				);
			}
		}

		return entityArray;
	}
}

/**
 * Type of an object containing a reference to an entity's internal location.
 *
 * No actual information about the entity's properties is stored beyond its type.
 */
export interface EntityReference {
	/** The type of entity. */
	type: EntityTypeID;
	/** The location of the referenced entity. */
	loc: number;
}
