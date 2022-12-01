<script setup>
import { defineComponent } from "vue";
import QRCode from "qrcode";
import Button from "./ui/Button.vue";
import MatIcon from "./ui/MatIcon.vue";
</script>

<template>
  <div class="qr-section">
    <Button class="generate" @click="createQRCode">
      <MatIcon class="mx-1">qr_code</MatIcon>
      <p class="font-bold">Generate QRCode</p>
    </Button>

    <div class="qrcode" v-if="qrcodeURL">
      <img
        :src="qrcodeURL"
        :title="`${config.VITE_SHORTURL_LINK}/${response.hash}`"
      />
    </div>
    <Button @click="downloadQRCode" class="download" v-if="qrcodeURL">
      <MatIcon class="mx-1">file_download</MatIcon>
      <p>Download QRCode</p>
    </Button>
  </div>
</template>

<script>
export default defineComponent({
  props: {
    config: {
      type: Object,
      required: true,
    },
    response: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      hash: null,
      qrcodeURL: null,
    };
  },
  updated() {
    if (this.hash !== this.response.hash && this.hash != null) {
      this.hash = this.response.hash;
      this.qrcodeURL = null;
    }
  },
  methods: {
    async createQRCode() {
      this.qrcodeURL = await QRCode.toDataURL(
        `${this.config.VITE_SHORTURL_LINK}/${this.hash}`,
        {
          errorCorrectionLevel: "H",
          width: 256,
          scale: 1,
          margin: 0,
        }
      )
        .then((_) => _)
        .catch((err) => {
          throw err;
        });
    },
    downloadQRCode() {
      const a = document.createElement("a");
      a.href = this.qrcodeURL;
      a.download = `qr-${new Date().getTime()}`;
      a.target = "_blank";
      a.click();
    },
  },
});
</script>

<style lang="scss" scoped>
.qr-section {
  @apply flex flex-col;
  @apply justify-center;
  @apply items-center;
  .generate {
    @apply bg-blue-500;
    @apply text-center text-white;
    @apply w-full;
    @apply rounded-md;
    @apply justify-center;
  }
  .qrcode {
    @apply flex-row;
    @apply justify-center items-center;
    @apply my-2;
    @apply p-2;
    @apply shadow-md;
    @apply rounded-md;
    @apply bg-gray-200;
  }
  .download {
    @apply flex flex-row;
    @apply justify-center;
    @apply text-center text-white;
    @apply font-bold;
    @apply w-full;
    @apply bg-green-500;
    @apply rounded-md;
  }
}
</style>
