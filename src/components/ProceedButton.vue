<template>
	<!-- The @click event handler doesn't quite handle all edge cases but it should be sufficient -->
	<button class="proceed-button" @click="proceed">Proceed</button>
</template>

<script setup lang="ts">
import game from '@/scripts/game';

function proceed() {
	game.turnHandler.value.proceed();
}
</script>

<style lang="css" scoped>
.proceed-button {
	border: 2px solid black;
	width: 100%;
	margin-top: 1em;
	padding: 1em;
	background-image: linear-gradient(35deg, #ee8811, #ff9922);
	transition: cubic-bezier(0.075, 0.82, 0.165, 1) 1s;
	cursor: pointer;

	&:hover {
		/* legacy compatibility be damned */
		scale: 1.1;
	}
}
</style>
