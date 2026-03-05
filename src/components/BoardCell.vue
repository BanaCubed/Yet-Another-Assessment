<script setup lang="ts">
import type { BoardCellEntityReference } from '@/scripts/board';
import type { GenericEntity } from '@/scripts/entity';

defineProps<{
	entities?: GenericEntity[] | BoardCellEntityReference[];
}>();
</script>

<template>
	<div v-for="entity in entities">John</div>
</template>

<style lang="css" scoped></style>
