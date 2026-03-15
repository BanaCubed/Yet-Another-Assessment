import { type CoordinatePair, CoordinatePairZero } from '../abstract';

/**
 * Enum containing all valid types of entities.
 */
enum EntityTypes {
	Generic,
	Player,
}
export default EntityTypes;

/**
 * Represents a generic entity type, from which other entities are derived.
 */

export class GenericEntity {
	/** Indicator of the type of entity based on {@link EntityTypes}. */
	public entityType: EntityTypes = EntityTypes.Generic;
	/** The location of the entity. */
	public location: CoordinatePair = CoordinatePairZero;

	constructor(coordinates?: CoordinatePair) {
		this.location = coordinates ?? { x: 0, y: 0 };
	}
}
