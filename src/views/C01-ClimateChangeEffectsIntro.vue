<i18n>
{
  "de": {
    "title": "Was sind die größten Auswirkungen des Klimawandels?",
    "title_direct": "Direkte Auswirkungen",
    "title_indirect": "Indirekte Auswirkungen ",
    "effect_direct_1": "Temperaturanstieg",
    "effect_direct_2": "Änderung der Regenmenge und -häufigkeit (u.a. Starkregen)",
    "effect_direct_3": "Häufigere Dürre- und Hitzeperioden",
    "effect_direct_4": "Wirbelstürme wie Hurricanes treten häufiger und stärker auf (Tornados in Europa)",
    "effect_direct_5": "Anstieg des Meeresspiegels",
    "effect_direct_6": "Verschiebung der Jahreszeiten (Dauer und Temperaturen)",
    "effect_direct_7": "Arktis wird bis zur Mitte des Jahrhunderts im Sommer eisfrei sein",
    "effect_indirect_1": "Wassermangel",
    "effect_indirect_2": "Ernteeinbussen",
    "effect_indirect_3": "Lebensräume für Tiere wie Pflanzen gehen verloren",
    "effect_indirect_4": "Flucht (Migration)",
    "effect_indirect_5": "Neue Krankheiten (tropische Krankheiten in Europa)",
    "effect_indirect_6": "Waldbrände",
    "effect_indirect_7": "Überflutungen",
    "subtitle_msg": "In den letzten Jahrzehnten wurde ein Anstieg von ca. 0,5°C gemessen. Bis 2100 erwartet man weitere 1,5 bis 3°C. Die Auswirkungen sind regional sehr unterschiedlich und im Detail schwer vorherzusagen",
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
              <li>{{ $t('effect_direct_4') }}</li>
              <li>{{ $t('effect_direct_5') }}</li>
              <li>{{ $t('effect_direct_6') }}</li>
              <li>{{ $t('effect_direct_7') }}</li>
            </ul>
          </div>
          <div class="column col-5">
            <h5>{{ $t('title_indirect') }}</h5>
            <ul>
              <li>{{ $t('effect_indirect_1') }}</li>
              <li>{{ $t('effect_indirect_2') }}</li>
              <li>{{ $t('effect_indirect_3') }}</li>
              <li>{{ $t('effect_indirect_4') }}</li>
              <li>{{ $t('effect_indirect_5') }}</li>
              <li>{{ $t('effect_indirect_6') }}</li>
              <li>{{ $t('effect_indirect_7') }}</li>
            </ul>
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
      this.$router.push({ name: 'Z00_WIP' });
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
