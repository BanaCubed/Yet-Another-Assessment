<script setup lang="ts">
import game from '@/scripts/game';
import BoardCell from './BoardCell.vue';
</script>

<template>
	<div id="board-container">
		<!--
			Entities that exist outside the board's main grid size aren't rendered.
			I'm going to pretend this is intentional and won't be an issue later
		-->
		<div class="board-row" v-for="row in game.boardState.size.x">
			<div class="board-cell" v-for="col in game.boardState.size.y">
				<div class="cell-content">
					<BoardCell :entities="game.boardState.cellData[row]?.[col]" />
				</div>
			</div>
		</div>
	</div>
</template>

<style lang="css" scoped>
#board-container {
	width: fit-content;
	height: fit-content;
}

.board-row {
	display: flex;
	flex-direction: row;
}

.board-cell {
	border: 2px black solid;
	width: 50px;
	height: 50px;
}
</style>
