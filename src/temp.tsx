import OverlayEntity from './scripts/entities/overlay';
import PlayerEntity from './scripts/entities/player';
import game from './scripts/game';

export function runTemp() {
	game.boardState.value.addEntity(new PlayerEntity({ x: 5, y: 5 }));
	game.boardState.value.addEntity(
		new OverlayEntity(
			{ x: 4, y: 5 },
			() => <>J</>,
			() => {
				console.log('SUCCESS!!!!!');
			},
		),
	);
}
