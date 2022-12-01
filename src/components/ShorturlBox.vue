<script setup>
import { defineComponent } from "vue";
import Button from "./ui/Button.vue";
import MatIcon from "./ui/MatIcon.vue";
</script>
<template>
  <form @submit.prevent="shortenURL()" class="shorturl-box">
    <input
      placeholder="Enter url here"
      type="text"
      minlength="2"
      required
      v-model="url"
    />
    <Button>
      <p class="font-semibold">Shorten URL</p>
      <MatIcon class="mx-1">send</MatIcon>
    </Button>
  </form>
</template>
<script>
export default defineComponent({
  props: {
    config: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      url: "",
    };
  },
  methods: {
    async shortenURL() {
      const response = await fetch(this.config.API_ENDPOINT, {
        method: "POST",
        body: JSON.stringify({
          url: encodeURI(this.url),
        }),
        headers: {
          "Content-Type": "application/json",
        },
      })
        .then((response) => {
          if (!response.ok) {
            throw new Error("Invalid Response");
          }
          return response.json();
        })
        .catch((error) => {
          this.$emit("error", true);
          this.$emit("callback", {
            response: null,
            url: encodeURI(this.url),
          });
          throw error;
        });
      this.url = encodeURI(this.url);
      this.$emit("error", false);
      this.$emit("setResponse", response);
      this.$emit("setProperty", "url", this.url);
    },
  },
});
</script>

<style lang="scss" scoped>
.shorturl-box {
  @apply flex flex-row gap-1;
  @apply justify-center items-center;
  @apply mb-2;
  @apply w-full;
  input {
    @apply p-2;
    @apply rounded-md;
    @apply w-[50%] md:w-[20%];
  }
  button {
    @apply bg-blue-500;
    @apply text-sm md:text-base;
    @apply text-white;
    @apply rounded-md;
    @apply justify-center;
    @apply items-center;
  }
}
</style>
