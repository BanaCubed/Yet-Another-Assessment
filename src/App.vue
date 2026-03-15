<script setup lang="ts">
import LevelBoard from './components/LevelBoard.vue';
import game from './scripts/game';
</script>

<template>
	<LevelBoard :state="game.boardState" />
</template>

<style scoped></style>
