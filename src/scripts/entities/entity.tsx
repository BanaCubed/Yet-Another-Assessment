import type { JSX } from 'vue/jsx-runtime';
import { type CoordinatePair, CoordinatePairZero } from '../abstract';
import { computed, type ComputedRef } from 'vue';

/**
 * Enum containing all valid types of entities.
 */
export enum EntityTypes {
	Generic,
	Player,
}

/**
 * Represents a generic entity type, from which other entities are derived.
 */
export default class Entity {
	/** Indicator of the type of entity based on {@link EntityTypes}. */
	public entityType: EntityTypes = EntityTypes.Generic;
	/** The location of the entity. */
	public location: CoordinatePair = CoordinatePairZero;

	constructor(coordinates?: CoordinatePair) {
		this.location = coordinates ?? { x: 0, y: 0 };
	}

	/**
	 * Renders the entity using its current status and such.
	 */
	public render?: () => JSX.Element;

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
}

export const entityFallbackRenderer: () => JSX.Element = () => <div>???</div>;
