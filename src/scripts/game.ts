import { ref, type Ref } from 'vue';
import { BoardState } from './board';

/**
 * Type of an object containing all information about the game that is currently being used.
 *
 * @see {@link BoardState}
 */
export interface GameState {
	/** The state of the current board. */
	boardState: BoardState;
	/** Index of the valid turn statuses that the game is currently in. */
	turnStatus: TurnStatusID;
}

export enum TurnStatusID {
	preview = -2, // Likely to end up unused, but would be used for level previews.
	menu = -1,
	playerTurn = 0,
	enemyTurn = 1,
}

/**
 * Object containing all information about the game's current state.
 */
const gameState: GameState = {
	boardState: new BoardState({ x: 5, y: 5 }),
	turnStatus: TurnStatusID.menu,
};

declare global {
	interface Window {
		game: Ref<GameState>;
	}
}

export default window.game = ref(gameState) as Ref<GameState>;
