<template>
  <div class="modal" v-bind:class="{ active: modalOpen }">
    <div class="modal-container">
        <div class="modal-header">
          <div class="modal-title h1 text-center">
            Hello, Hallo! 🙌
          </div>
        </div>
      <div class="modal-body">
        <div class="columns col-gapless">
          <div class="column col-6">
            <center>
              <h5>
                What language do you speak?
              </h5>
              <button @click="next('en')" class="btn btn-lg btn-success">
                🇬🇧 English
              </button>
            </center>
          </div>
          <div class="column col-6">
            <center>
              <h5>
                Welche Sprache sprichst du?
              </h5>
              <button @click="next('de')" class="btn btn-lg btn-success">
                🇩🇪 Deutsch
              </button>
            </center>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Helper from '@/helper';

export default {
  name: 'EntryLanguageSelect',

  data() {
    return {
      modalOpen: false,
    };
  },

  mounted() {
    Helper.sleep(4, () => {
      this.modalOpen = true;
    });
  },

  methods: {
    next(locale) {
      this.$i18n.locale = locale;
      this.$router.push({ name: 'A02-EntryWelcome' });
    },
  },
};
</script>
