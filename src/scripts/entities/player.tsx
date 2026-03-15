import type { CoordinatePair } from '../abstract';
import Entity, { EntityTypes } from './entity';
import { computed } from 'vue';

/**
 * Represents a player entity, which can be controlled by the player during their turn.
 */
export default class PlayerEntity extends Entity {
	constructor(coordinates: CoordinatePair) {
		super(coordinates);
		this.entityType = EntityTypes.Player;

		this.render = () => <>P</>;
	}
}
