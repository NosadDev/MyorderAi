<script setup>
import { defineComponent } from "vue";
import Branding from "./components/Branding.vue";
import Error from "./components/Error.vue";
import ResultBox from "./components/ResultBox.vue";
import ShorturlBox from "./components/ShorturlBox.vue";
</script>

<template>
  <div class="container">
    <Branding class="mb-2"></Branding>
    <Error v-if="error"></Error>
    <ShorturlBox
      @error="setError"
      @setResponse="setResponse"
      @setProperty="setProperty"
      :config="config"
    ></ShorturlBox>
    <ResultBox :url="url" :response="response" :config="config"> </ResultBox>
  </div>
</template>

<script>
export default defineComponent({
  data() {
    return {
      config: {
        SHORTURL_LINK: import.meta.env.VITE_SHORTURL_LINK,
        API_ENDPOINT: {
          SCHEME: import.meta.env.VITE_API_ENDPOINT_SCHEME,
          URL: import.meta.env.VITE_API_ENDPOINT,
        },
      },
      url: "",
      error: false,
      response: null,
    };
  },
  methods: {
    setError(error) {
      this.error = error;
    },
    setResponse(response) {
      this.response = response;
    },
    setProperty(key, value) {
      this[key] = value;
    },
  },
});
</script>

<style lang="scss" scoped>
.container {
  @apply flex flex-col;
  @apply min-h-[100vh];
  @apply w-full;
  @apply p-2;
  @apply justify-center items-center;
  @apply min-w-[100vw];
}
</style>
