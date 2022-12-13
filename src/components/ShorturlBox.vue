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
      maxlength="255"
      required
      v-model="url"
    />
    <Button :disabled="pending">
      <p class="font-semibold">Shorten URL</p>
      <MatIcon class="mx-1 animate-spin" v-if="pending">autorenew</MatIcon>
      <MatIcon class="mx-1" v-else>send</MatIcon>
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
      pending: false,
    };
  },
  methods: {
    async shortenURL() {
      this.pending = true;
      const response = await fetch(
        `${this.config.API_ENDPOINT.SCHEME}://${this.config.API_ENDPOINT.URL}`,
        {
          method: "POST",
          body: JSON.stringify({
            url: encodeURI(this.url),
          }),
          headers: {
            "Content-Type": "application/json",
          },
        }
      )
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
          this.pending = false;
          throw error;
        });
      this.url = encodeURI(this.url);
      this.$emit("error", false);
      this.$emit("setResponse", response);
      this.$emit("setProperty", "url", this.url);
      this.pending = false;
    },
  },
});
</script>

<style lang="scss" scoped>
.shorturl-box {
  @apply flex flex-row gap-1;
  @apply justify-center items-center;
  @apply mb-2;
  @apply w-full md:w-[50%] lg:w-[40%] xl:w-[30%];
  input {
    @apply p-2;
    @apply rounded-md;
    @apply w-[60%] 2xl:w-[70%];
    @apply overflow-x-auto;
  }
  button {
    @apply w-[40%] 2xl:w-[30%];
    @apply bg-blue-500;
    @apply text-sm md:text-base;
    @apply text-white;
    @apply rounded-md;
    @apply justify-center;
    @apply items-center;
    @apply disabled:opacity-75;
  }
}
</style>
