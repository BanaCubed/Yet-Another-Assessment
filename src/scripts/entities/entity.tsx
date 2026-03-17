import type { JSX } from 'vue/jsx-runtime';
import { type CoordinatePair, CoordinatePairZero } from '../abstract';
import type { GameState } from '../game';
import type { BoardState } from '../board';

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

	public onPlayerTurnStart?: EntityEventHandler;
	public onPlayerTurnEnd?: EntityEventHandler;
	public onEnemyTurnStart?: EntityEventHandler;
	public onRoundEnd?: EntityEventHandler;
}

export const entityFallbackRenderer: () => JSX.Element = () => <div>???</div>;
