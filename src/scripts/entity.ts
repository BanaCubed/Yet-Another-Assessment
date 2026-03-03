import type { CoordinatePair } from './abstract';

/**
 * Enum containing all valid types of entities.
 */
export enum EntityTypes {
	Player,
}

/**
 * Type of an object containing information about a generic entity.
 *
 * Specific entities, like {@link PlayerEntity} have extra properties extended off of this interface.
 */
export interface GenericEntity {
	/** Indicator of the type of entity based on {@link EntityTypes}. */
	entityType: EntityTypes;
	/** The location of the entity. */
	location: CoordinatePair;
}

/**
 * Type of an object containing information about a player entity.
 */
export interface PlayerEntity extends GenericEntity {
	/**
	 * Indicator of the type of entity based on {@link EntityTypes}.
	 * This is always {@link EntityTypes.Player} for player entities.
	 */
	entityType: EntityTypes.Player;
}
