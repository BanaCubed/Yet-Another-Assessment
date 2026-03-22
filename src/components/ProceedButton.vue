<template>
	<button class="proceed-button" @click="proceed" @touchend="proceed" @mouseup="proceed">
		Proceed
	</button>
</template>

<script setup lang="ts">
import game from '@/scripts/game';

function proceed() {
	game.value.turnHandler.proceed();
}
</script>

<style lang="css" scoped>
.proceed-button {
	border: 2px solid black;
}
</style>
