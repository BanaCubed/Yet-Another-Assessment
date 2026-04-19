import { createApp } from 'vue';
import App from './App.vue';
import game from './scripts/game';
import PlayerEntity from './scripts/entities/player';
import OverlayEntity from './scripts/entities/overlay';
import { runTemp } from './temp';

createApp(App).mount('#app');

runTemp();
