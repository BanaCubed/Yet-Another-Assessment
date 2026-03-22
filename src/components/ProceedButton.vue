<template>
	<!-- The @click event handler doesn't quite handle all edge cases but it should be sufficient -->
	<button class="proceed-button" @click="proceed">Proceed</button>
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
