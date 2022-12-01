<script setup>
import { defineComponent } from "vue";
</script>
<template>
  <div class="error">Something went wrong. Please try again later.</div>
</template>

<script>
export default defineComponent({});
</script>

<style lang="scss" scoped>
.error {
  @apply bg-red-200;
  @apply rounded-md shadow-md;
  @apply flex-row;
  @apply mb-2 px-2;
}
</style>
