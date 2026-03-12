import { BoardState, type BoardCellEntityReference } from './board';

/**
 * Type of an object containing all information about the game that is currently being used.
 *
 * @see {@link BoardState}
 */
export interface GameState {
	/** The state of the current board. */
	boardState: BoardState;
}

/**
 * Object containing all information about the game's current state.
 */
const gameState: GameState = {
	boardState: new BoardState({ x: 5, y: 5 }),
};

export function removeCellData(x: number, y: number, data: BoardCellEntityReference) {
	const foundIndexes: number[] = [];
	(gameState.boardState.cellData[x]?.[y] as BoardCellEntityReference[])?.filter(
		(predicate, index) => {
			// If the function is overzealous turning this into a strict equality might help
			if (predicate == data) {
				foundIndexes.push(index);
			}
		},
	);

	foundIndexes.forEach((element) => {
		(gameState.boardState.cellData[x]?.[y] as BoardCellEntityReference[])?.splice(element, 1);
	});
}

// #endregion BoardState Modification

declare global {
	interface Window {
		game: GameState;
	}
}

export default window.game = gameState as GameState;
