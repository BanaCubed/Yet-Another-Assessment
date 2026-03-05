import type { BoardCellEntityReference, BoardState } from './board';

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
	boardState: {
		size: {
			x: 5,
			y: 5,
		},
		cellData: [],
	},
};

export function addCellData(x: number, y: number, data: BoardCellEntityReference) {
	(gameState.boardState.cellData[x]?.[y] as BoardCellEntityReference[])?.push(data);
}

declare global {
	interface Window {
		game: GameState;
	}
}

export default window.game = gameState as GameState;
