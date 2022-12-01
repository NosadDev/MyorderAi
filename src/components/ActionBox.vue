<script setup>
import { defineComponent } from "vue";
import Button from "./ui/Button.vue";
import MatIcon from "./ui/MatIcon.vue";
</script>

<template>
  <div class="action-box">
    <div class="title">{{ title }}</div>
    <input type="text" readonly :value="value" />
    <div class="button-group">
      <Button @click="copyURL">
        <MatIcon title="Copy">content_copy</MatIcon>
      </Button>
      <Button @click="openURL">
        <MatIcon title="Open in new tab">open_in_new</MatIcon>
      </Button>
    </div>
  </div>
</template>

<script>
export default defineComponent({
  props: {
    title: {
      type: String,
      required: true,
    },
    value: {
      type: String,
      required: true,
    },
  },
  methods: {
    openURL() {
      const a = document.createElement("a");
      if (/^(http|https):\/\//.test(this.value)) {
        a.href = this.value;
      } else {
        a.href = `http://${this.value}`;
      }
      a.target = "_blank";
      a.click();
    },
    copyURL() {
      if (!navigator.clipboard) {
        this.fallbackSetClipboard(this.value);
        return;
      }
      navigator.clipboard.writeText(this.value);
    },
    fallbackSetClipboard() {
      const textArea = document.createElement("textarea");
      textArea.value = this.value;

      textArea.style.top = "0";
      textArea.style.left = "0";
      textArea.style.position = "fixed";

      document.body.appendChild(textArea);
      textArea.focus();
      textArea.select();
      document.execCommand("copy");
      document.body.removeChild(textArea);
    },
  },
});
</script>

<style lang="scss" scoped>
.action-box {
  @apply flex-row;
  @apply flex;
  @apply gap-1;
  .title {
    @apply p-2;
    @apply bg-gray-200;
    @apply text-center;
    @apply font-bold;
    @apply rounded-md;
    @apply w-[25%];
  }
  input {
    @apply flex-col;
    @apply bg-gray-200;
    @apply rounded-md;
    @apply p-2;
    @apply truncate;
    @apply w-[50%];
  }
  .button-group {
    @apply flex flex-row gap-1;
    @apply w-[25%];
    @apply justify-around;
    button {
      @apply bg-gray-200;
      @apply rounded-md;
    }
  }
}
</style>
