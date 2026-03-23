import { computed } from 'vue';
import type { CoordinatePair } from '../abstract';
import Entity, { EntityTypeID, type EntityEventHandler } from './entity';
import type { JSX } from 'vue/jsx-runtime';

/**
 * Represents an overlay entity, which should have no direct gameplay affects,
 * but can be used to indicate to the player otherwise hidden information.
 */
export default class OverlayEntity extends Entity {
	constructor(coordinates: CoordinatePair, display: () => JSX.Element) {
		super(coordinates);
		this.entityType = EntityTypeID.Overlay;

		this.computedRender = computed(display);
	}

	public onPlayerTurnEnd?: EntityEventHandler | undefined = () => {
		this.markForDestruction = true;
	};
	public onRoundEnd?: EntityEventHandler | undefined = () => {
		this.markForDestruction = true;
	};
}
