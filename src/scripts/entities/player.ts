import type { CoordinatePair } from '../abstract';
import EntityTypes, { GenericEntity } from './generic';

/**
 * Represents a player entity, which can be controlled by the player during their turn.
 */

export default class PlayerEntity extends GenericEntity {
	constructor(coordinates: CoordinatePair) {
		super(coordinates);
		this.entityType = EntityTypes.Player;
	}
}
