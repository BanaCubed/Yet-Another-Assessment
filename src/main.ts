import { createApp } from 'vue';
import App from './App.vue';
import game from './scripts/game';
import PlayerEntity from './scripts/entities/player';

createApp(App).mount('#app');

game.value.boardState.addEntity(new PlayerEntity({ x: 5, y: 5 }));
