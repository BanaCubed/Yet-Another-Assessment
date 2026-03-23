import type { BoardState } from './board';
import { EntityTypeID } from './entities/entity';
import game from './game';

export enum TurnStatusID {
	Preview = -2, // Likely to end up unused, but would be used for level previews.
	Menu = -1,
	PlayerTurn = 0,
	EnemyTurn = 1,
}

export default class TurnHandler {
	// Once a menu system is in place the start turn status should be changed to TurnStatusID.Menu
	public status: TurnStatusID = TurnStatusID.PlayerTurn;
	public turnCount: number = 0;

	/**
	 * Proceeds the current turn status into the next one, and calls the relevant event handlers.
	 */
	public proceed() {
		console.log('Proceeding');
		if (this.status === TurnStatusID.PlayerTurn) {
			console.log('Proceeding: Running onPlayerTurnEnd handlers.');
			TurnHandler.runOnPlayerTurnEnd(game.value.boardState);

			this.status = TurnStatusID.EnemyTurn;
			console.log('Proceeding: Running onEnemyTurnStart handlers.');
			TurnHandler.runOnEnemyTurnStart(game.value.boardState);
		} else if (this.status === TurnStatusID.EnemyTurn) {
			console.log('Proceeding: Running onRoundEnd handlers.');
			TurnHandler.runOnRoundEnd(game.value.boardState);

			this.status = TurnStatusID.PlayerTurn;
			console.log('Proceeding: Running onPlayerTurnStart handlers.');
			TurnHandler.runOnPlayerTurnStart(game.value.boardState);
		}
	}

	// I cannot be bothered to simplify this.
	// Also this should run perfectly fine so no particular need to.
	private static runOnPlayerTurnStart(board: BoardState) {
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

	private static runOnPlayerTurnEnd(board: BoardState) {
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

	private static runOnEnemyTurnStart(board: BoardState) {
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

	private static runOnRoundEnd(board: BoardState) {
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
