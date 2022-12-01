<script setup>
import { defineComponent } from "vue";
import ActionBox from "./ActionBox.vue";
import QRCodeBox from "./QRCodeBox.vue";
</script>

<template>
  <div class="result-box" v-if="response !== null">
    <ActionBox class="mb-1" :title="'Original'" :value="url"></ActionBox>
    <ActionBox
      class="mb-1"
      :title="'Shorten'"
      :value="`${config.SHORTURL_LINK}/${response.hash}`"
    ></ActionBox>
    <QRCodeBox :config="config" :response="response"></QRCodeBox>
  </div>
</template>
<script>
export default defineComponent({
  props: {
    url: {
      type: String,
      required: true,
    },
    response: {
      required: true,
    },
    config: {
      type: Object,
      required: true,
    },
  },
});
</script>
<style lang="scss" scoped>
.result-box {
  @apply flex-col;
  @apply bg-white;
  @apply p-2;
  @apply rounded-md;
  @apply w-full md:w-[50%] lg:w-[40%] xl:w-[30%];
}
</style>
