import EntityTypes, { GenericEntity } from './generic';

/**
 * Represents a player entity, which can be controlled by the player during their turn.
 */

export default class PlayerEntity extends GenericEntity {
	constructor() {
		super();
		this.entityType = EntityTypes.Player;
	}
}
