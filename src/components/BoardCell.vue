<script setup lang="ts">
import type { EntityReference } from '@/scripts/board';
import { GenericEntity } from '@/scripts/entities/generic';
import game from '@/scripts/game';
import { computed } from 'vue';

const props = defineProps<{
	entities?: GenericEntity[];
}>();
</script>

<template>
	<div v-for="entity in entities">{{ entity.entityType }}</div>
</template>

<style lang="css" scoped></style>
