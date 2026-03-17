import type { BoardState } from './board';
import type Entity from './entities/entity';
import { EntityTypeID } from './entities/entity';
import game from './game';

export enum TurnStatusID {
	Preview = -2, // Likely to end up unused, but would be used for level previews.
	Menu = -1,
	PlayerTurn = 0,
	EnemyTurn = 1,
}

export default class TurnHandler {
	public status: TurnStatusID = TurnStatusID.Menu;
	public turnCount: number = 0;

	/**
	 * Proceeds the current turn status into the next one, and calls the relevant event handlers.
	 */
	public proceed() {
		if (this.status === TurnStatusID.PlayerTurn) {
			this.runOnPlayerTurnEnd(game.value.boardState);

			this.status = TurnStatusID.EnemyTurn;
			this.runOnEnemyTurnStart(game.value.boardState);
		} else if (this.status === TurnStatusID.EnemyTurn) {
			this.runOnRoundEnd(game.value.boardState);

			this.status = TurnStatusID.PlayerTurn;
			this.runOnPlayerTurnStart(game.value.boardState);
		}
	}

	// I cannot be bothered to simplify this.
	// Also this should run perfectly fine so no particular need to.
	private runOnPlayerTurnStart(board: BoardState) {
		const ids: EntityTypeID[] = Object.values(EntityTypeID).filter((key) =>
			isNaN(Number(EntityTypeID[key as unknown as number])),
		) as EntityTypeID[];

		for (const id of ids) {
			board.entityData[id]?.forEach((value) => {
				if (value === undefined) return;
				value.onPlayerTurnStart?.(board);
			});
		}
	}

	private runOnPlayerTurnEnd(board: BoardState) {
		// There's not a chance in hell this works properly for player movement
		const ids: EntityTypeID[] = Object.values(EntityTypeID).filter((key) =>
			isNaN(Number(EntityTypeID[key as unknown as number])),
		) as EntityTypeID[];

		for (const id of ids) {
			board.entityData[id]?.forEach((value) => {
				if (value === undefined) return;
				value.onPlayerTurnEnd?.(board);
			});
		}
	}

	private runOnEnemyTurnStart(board: BoardState) {
		// Top 10 inconsistent setups of all time
		const ids: EntityTypeID[] = Object.values(EntityTypeID).filter((key) =>
			isNaN(Number(EntityTypeID[key as unknown as number])),
		) as EntityTypeID[];

		for (const id of ids) {
			board.entityData[id]?.forEach((value) => {
				if (value === undefined) return;
				value.onEnemyTurnStart?.(board);
			});
		}
	}

	private runOnRoundEnd(board: BoardState) {
		const ids: EntityTypeID[] = Object.values(EntityTypeID).filter((key) =>
			isNaN(Number(EntityTypeID[key as unknown as number])),
		) as EntityTypeID[];

		for (const id of ids) {
			board.entityData[id]?.forEach((value) => {
				if (value === undefined) return;
				value.onRoundEnd?.(board);
			});
		}
	}
}
