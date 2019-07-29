<template>
  <div class="modal" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <div class="modal-title h1 text-center">Hello, Hallo! 🙌</div>
      </div>
      <div class="modal-body text-center mb-2">
        <button @click="next('en')" class="btn btn-lg btn-success mx-2 mb-1">💂‍♀️ I speak English</button>
        <button @click="next('de')" class="btn btn-lg btn-success mx-2 mb-1">🥨 Ich spreche Deutsch</button>
      </div>
    </div>
  </div>
</template>

<script>
import Helper from "@/utils/helper";

export default {
  mounted() {
    this.$parent.$data.modalOpen = false;
    Helper.sleep(4, () => {
      this.$parent.$data.modalOpen = true;
    });
  },

  methods: {
    next(locale) {
      this.$parent.$data.modalOpen = false;
      this.$i18n.locale = locale;

      this.$router.push({ name: "A02-EntryWelcome" });
    }
  }
};
</script>
