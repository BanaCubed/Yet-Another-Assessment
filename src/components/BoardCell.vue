<script setup lang="tsx">
import type { CoordinatePair } from '@/scripts/abstract';
import Entity, { entityFallbackRenderer } from '@/scripts/entities/entity';
import { computed, type ComputedRef } from 'vue';
import type { JSX } from 'vue/jsx-runtime';

const props = defineProps<{
	entities: Entity[];
	location: CoordinatePair;
}>();

const Renderer: ComputedRef<JSX.Element> = computed(() => {
	const computedRenderers = [];
	for (let i = 0; i < props.entities.length; i++) {
		const entity = props.entities[i];

		computedRenderers.push(entity?.computedRender ?? computed(() => <></>));
	}

	console.log(computedRenderers);

	return (
		<>
			{computedRenderers.map((el) => (
				<div class="entity-render">e{el.value}</div>
			))}
		</>
	);
});
</script>

<template>
	<component :is="Renderer" />
	<div class="coordinate-overlay">({{ location.x }}, {{ location.y }})</div>
</template>

<style lang="css" scoped>
.entity-render {
	position: absolute;
	top: 50%;
	left: 50%;
	display: block;
	translate: -50% -50%;
}

.coordinate-overlay {
	position: absolute;
	bottom: 5%;
	left: 5%;
	font-size: 0.8em;
	opacity: 0.75;
}
</style>
