import type { JSX } from 'vue/jsx-runtime';
import { type CoordinatePair, CoordinatePairZero } from '../abstract';
import type { BoardState } from '../board';
import { computed, type ComputedRef } from 'vue';

/**
 * Enum containing all valid types of entities.
 */
export enum EntityTypeID {
	Generic,
	Player,
	Overlay,
}

export type EntityEventHandler = (board: BoardState) => void;

/**
 * Represents a generic entity type, from which other entities are derived.
 */
export default class Entity {
	/** Indicator of the type of entity based on {@link EntityTypeID}. */
	public entityType: EntityTypeID = EntityTypeID.Generic;
	/** The location of the entity. */
	public location: CoordinatePair = CoordinatePairZero;
	/** Whether this entity should be cleaned up on the next turn proceeding. */
	public markForDestruction: boolean = false;

	constructor(coordinates?: CoordinatePair) {
		this.location = coordinates ?? { x: 0, y: 0 };
	}

	/**
	 * Renders the entity using its current status and such.
	 */
	public functionRender: () => JSX.Element = () => entityFallbackRenderer;

	/**
	 * Moves the current entity along the board by a specified value.
	 * Can accept relative coordinates to add to the current coordinates.
	 */
	public move(coordinates: CoordinatePair, relative: boolean = true) {
		if (relative) {
			this.location.x += coordinates.x;
			this.location.y += coordinates.y;
		} else {
			this.location = coordinates;
		}
	}

	public onPlayerTurnStart?: EntityEventHandler;
	public onPlayerTurnEnd?: EntityEventHandler;
	public onEnemyTurnStart?: EntityEventHandler;
	public onRoundEnd?: EntityEventHandler;
}

export const entityFallbackRenderer: JSX.Element = <div>???</div>;
