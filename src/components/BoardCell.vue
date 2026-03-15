<script setup lang="tsx">
import type { CoordinatePair } from '@/scripts/abstract';
import Entity, { entityFallbackRenderer } from '@/scripts/entities/entity';
import { computed, type ComputedRef } from 'vue';
import type { JSX } from 'vue/jsx-runtime';

const props = defineProps<{
	entities: Entity[];
	location: CoordinatePair;
}>();

const renderers: ComputedRef<Array<(() => JSX.Element) | null>> = computed(() => {
	const array = [];
	for (let i = 0; i < props.entities.length; i++) {
		const entity = props.entities[i];

		array.push(entity?.render ?? entityFallbackRenderer);
	}
	return array;
});
</script>

<template>
	<component v-for="Renderer in renderers" :is="Renderer" class="entity-render" />
</template>

<style lang="css" scoped>
.entity-render {
	position: absolute;
	top: 50%;
	left: 50%;
	display: block;
	translate: -50% -50%;
}
</style>
