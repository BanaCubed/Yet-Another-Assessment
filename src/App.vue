<script setup lang="ts">
import LevelBoard from './components/LevelBoard.vue';
import game from './scripts/game';
</script>

<template>
	<LevelBoard :state="game.boardState" id="game-board" />
</template>

<style lang="css" scoped>
#game-board {
	position: absolute;
	top: 50%;
	left: 50%;
	translate: -50% -50%;
}
</style>
