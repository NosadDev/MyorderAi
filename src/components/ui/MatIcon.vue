<script setup>
import { defineComponent } from "vue";
</script>

<template>
  <span v-if="style" :class="'material-icons-' + style" v-bind="$attrs">
    <slot></slot>
  </span>
  <span v-else class="material-icons" v-bind="$attrs">
    <slot></slot>
  </span>
</template>

<script>
import 'material-icons/iconfont/material-icons.css';
export default defineComponent({
  props: {
    style: {
      type: String,
      required: false,
      validator(value) {
        return ["outlined", "round", "sharp", "two-tone"].includes(value);
      },
    },
  },
});
</script>
