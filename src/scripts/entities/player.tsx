import { computed } from 'vue';
import type { CoordinatePair } from '../abstract';
import Entity, { EntityTypeID, type EntityEventHandler } from './entity';

/**
 * Represents a player entity, which can be controlled by the player during their turn.
 */
export default class PlayerEntity extends Entity {
	constructor(coordinates: CoordinatePair) {
		super(coordinates);
		this.entityType = EntityTypeID.Player;

		this.functionRender = () => <div>P</div>;
	}

	public onPlayerTurnEnd?: EntityEventHandler | undefined = () => {
		this.functionRender = () => <div>P2</div>;
	};
}
