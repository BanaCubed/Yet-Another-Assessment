<script setup lang="ts">
import type { GenericEntity } from '@/scripts/entity';

defineProps<{
	entities: GenericEntity[];
}>();
</script>

<template>
	<div v-for="entity in entities">John</div>
</template>

<style lang="css" scoped></style>
