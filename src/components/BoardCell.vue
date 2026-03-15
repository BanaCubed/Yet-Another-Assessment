<script setup lang="tsx">
import Entity from '@/scripts/entities/entity';
import { computed, type ComputedRef } from 'vue';
import type { JSX } from 'vue/jsx-runtime';

const props = defineProps<{
	entities: Entity[];
}>();

const renderers: ComputedRef<Array<(() => JSX.Element) | null>> = computed(() => {
	const array = [];
	for (let i = 0; i < props.entities.length; i++) {
		const entity = props.entities[i];

		array.push(entity?.render ?? null);
	}
	return array;
});
</script>

<template>
	<div v-for="Renderer in renderers">
		<component :is="Renderer" />
	</div>
</template>

<style lang="css" scoped></style>
