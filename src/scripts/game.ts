import { computed, ref, type ComputedRef, type Ref } from 'vue';
import { BoardState } from './board';
import TurnHandler, { TurnStatusID } from './turns';

/**
 * Type of an object containing all information about the game that is currently being used.
 *
 * @see {@link BoardState}
 */
export interface GameState {
	/** The state of the current board. */
	boardState: Ref<BoardState>;
	/** The current turn handler. Exists outside of boardState to be quirky. */
	turnHandler: Ref<TurnHandler>;
}

/**
 * Object containing all information about the game's current state.
 */
const gameState: GameState = {
	boardState: ref(new BoardState({ x: 5, y: 5 })),
	turnHandler: ref(new TurnHandler()),
};

declare global {
	interface Window {
		game: GameState;
	}
}

export default window.game = gameState;
