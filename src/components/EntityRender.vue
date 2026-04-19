<template>
	<component class="entity-render" :is="display" />
</template>

<script setup lang="ts">
import type { ComputedRef } from 'vue';
import type { JSX } from 'vue/jsx-runtime';

defineProps<{
	display: ComputedRef<JSX.Element>;
}>();
</script>
