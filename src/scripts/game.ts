import { ref, type Ref } from 'vue';
import { BoardState, type EntityReference } from './board';

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
const gameState: Ref<GameState> = ref({
	boardState: new BoardState({ x: 5, y: 5 }),
});

declare global {
	interface Window {
		game: Ref<GameState>;
	}
}

export default window.game = gameState as Ref<GameState>;
