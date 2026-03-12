<script setup lang="ts">
import type { BoardCellEntityReference } from '@/scripts/board';
import { GenericEntity } from '@/scripts/entities/generic';
import game from '@/scripts/game';
import { computed } from 'vue';

const props = defineProps<{
	entities?: GenericEntity[] | BoardCellEntityReference[];
}>();

const computedEntities = computed<GenericEntity[]>(() => {
	// Return empty array if no usable data exists.
	if (props.entities === undefined) {
		return [];
	}
	if (props.entities.length === 0) {
		return [];
	}

	// Return existing array if no need to convert to `GenericEntity[]`
	if (props.entities[0] instanceof GenericEntity) {
		return props.entities as GenericEntity[];
	}

	const _arr: GenericEntity[] = [];
	for (let i = 0; i < props.entities.length; i++) {
		// Blame eslint for this abomination.
		const _el: BoardCellEntityReference = (props.entities as BoardCellEntityReference[])[
			i
		] as BoardCellEntityReference;
		if (_el !== undefined) {
			game.boardState.entityData[_el.type]?.[_el.loc];
		}
	}

	return _arr;
});
</script>

<template>
	<div v-for="entity in computedEntities">Placeholder</div>
</template>

<style lang="css" scoped></style>
