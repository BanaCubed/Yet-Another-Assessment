import { ref, type Ref } from 'vue';
import { BoardState } from './board';
import TurnHandler, { TurnStatusID } from './turns';

/**
 * Type of an object containing all information about the game that is currently being used.
 *
 * @see {@link BoardState}
 */
export interface GameState {
	/** The state of the current board. */
	boardState: BoardState;
	/** The current turn handler. Exists outside of boardState to be quirky. */
	turnHandler: TurnHandler;
}

/**
 * Object containing all information about the game's current state.
 */
const gameState: GameState = {
	boardState: new BoardState({ x: 5, y: 5 }),
	turnHandler: new TurnHandler(),
};

declare global {
	interface Window {
		game: Ref<GameState>;
	}
}

export default window.game = ref<GameState>(gameState) as Ref<GameState>;
