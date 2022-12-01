<template>
  <div class="branding">
    <div>Short</div>
    <div>URL</div>
  </div>
</template>

<style scoped lang="scss">
.branding {
  @apply flex-row flex items-center;
  div {
    @apply text-5xl text-white;
    @apply font-bold;
    @apply mx-1;
    &:nth-child(2) {
      @apply bg-blue-400;
      @apply rounded-md;
      @apply p-2;
    }
  }
}
</style>
