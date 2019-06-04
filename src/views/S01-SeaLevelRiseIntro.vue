<i18n>
{
  "de": {
    "title": "Was passiert eigentlich beim Anstieg des Meeresspiegels?",
    "title_direct": "Direkte Auswirkungen",
    "title_indirect": "Indirekte Auswirkungen ",
    "effect_direct_1": "Temperaturanstieg",
    "effect_direct_2": "Änderung der Regenmenge und -häufigkeit (u.a. Starkregen)",
    "effect_direct_3": "Häufigere Dürre- und Hitzeperioden",
    "subtitle_msg": "Der Anstieg des Meeresspiegels mag mit etwa 70cm bis 2100 gering wirken aber die Auswirkungen fallen regional äusserst unterschiedlich aus und wie sich der Anstieg über die kommenden Jahre beschleunigt kann man nicht exakt vorhersagen.",
    "next_btn": "weiter"
  }
}
</i18n>

<template>
  <div class="modal modal-lg" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right"
           aria-label="Close"></a>

        <div class="modal-title h4 flex-centered">
           {{ $t("title") }}
        </div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-2 flex-centered">
            <img class="img-responsive flex-end" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
          <div class="column col-5">
            <h5>{{ $t('title_direct') }}</h5>
            <ul>
              <li>{{ $t('effect_direct_1') }}</li>
              <li>{{ $t('effect_direct_2') }}</li>
              <li>{{ $t('effect_direct_3') }}</li>
            </ul>
          </div>
          <div class="column col-5">
            <h5>{{ $t('title_indirect') }}</h5>
          </div>
        </div>
      </div>
      <div class="modal-footer">
       <h5>{{ $t('subtitle_msg') }}</h5>
       <div class="columns">
          <div class="column col-1 flex-centered">
            <button @click="navBack" class="btn btn-lg btn float-left"><i class="icon icon-arrow-left"></i></button>
          </div>
          <div class="column col-8 flex-centered">
          </div>
          <div class="column col-3 flex-centered">
            <button @click="next" class="btn btn-lg btn-success float-right"> {{ $t('next_btn') }}<i class="icon icon-arrow-right"></i></button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  methods: {
    next() {
      this.$router.push({ name: 'B05-GreenhouseEffect5' });
    },

    modalClose() {
      this.$parent.modalClose();
    },

    navBack() {
      this.$router.back();
    },
  },
};
</script>
