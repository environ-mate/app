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
    "effect_direct_7": "Die Arktis wird bis zur Mitte des Jahrhunderts im Sommer eisfrei sein",
    "effect_indirect_1": "Wassermangel",
    "effect_indirect_2": "Ernteeinbußen",
    "effect_indirect_3": "Lebensräume für Tiere und Pflanzen gehen verloren",
    "effect_indirect_4": "Flucht (Migration)",
    "effect_indirect_5": "Neue Krankheiten (tropische Krankheiten in Europa)",
    "effect_indirect_6": "Waldbrände",
    "effect_indirect_7": "Überflutungen",
    "subtitle_msg": "In den letzten Jahrzehnten wurde ein Anstieg von ca. 0,5°C gemessen. Bis 2100 erwartet man weitere 1,5 bis 3°C. Die Auswirkungen sind regional sehr unterschiedlich und im Detail schwer vorherzusagen",
    "next_sea_level_btn": "Meeresspiegel",
    "next_desc": "Welche Auswirkungen der Klimawandel auf unser Wetter und den Meeresspiegel hat, kannst du dir jetzt anschauen",
    "next_ew_btn": "Extremwetter",
    "next_act_btn": "Was kannst du dagegen tun?"
  },
  "en": {
    "title": "What are the biggest consequences of climate change?",
    "title_direct": "Direct Consequences",
    "title_indirect": "Indirect Consequences",
    "effect_direct_1": "Rising temperatures",
    "effect_direct_2": "Changes in amount and frequency of rainfall",
    "effect_direct_3": "More frequent droughts and heatwaves",
    "effect_direct_4": "Major storms such as Hurricanes become more frequent and more severe (tornadoes in Europe)",
    "effect_direct_5": "Sea level rise",
    "effect_direct_6": "Shifts in seasonal patterns (durations and temperatures)",
    "effect_direct_7": "The Arctic will be ice-free in summer by mid-century",
    "effect_indirect_1": "Water scarcity",
    "effect_indirect_2": "Crop loss",
    "effect_indirect_3": "Loss of habitation for plant and animal species",
    "effect_indirect_4": "Mass migrations",
    "effect_indirect_5": "New diseases (tropical diseases spread to Europe)",
    "effect_indirect_6": "Wildfires",
    "effect_indirect_7": "Floods",
    "subtitle_msg": "Temperatures have risen around 0.5°C over the past decades. A further rise of between 1.5 to 3°C is expected by 2100. The consequences vary from region to region and are difficult to predict in detail.",
    "next_sea_level_btn": "Sea Level",
    "next_desc": "Now you can see what effects climate change has on our weather and sea level",
    "next_ew_btn": "Extreme Weather",
    "next_act_btn": "What can I do about it?"
  }
}
</i18n>

<template>
  <div class="modal modal-xl" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right" aria-label="Close"></a>

        <div class="modal-title h4">{{ $t("title") }}</div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-12"></div>
        </div>

        <div class="columns">
          <div class="column col-5 col-sm-10 col-xs-12 mb-2">
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
          <div class="column col-2 col-sm-2 col-xs-5 flex-end mb-2">
            <img
              class="img-responsive"
              v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"
            />
          </div>
          <div class="column col-5 col-sm-12">
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
        <div class="column col-12">
          <p>{{ $t('subtitle_msg') }}</p>
        </div>

        <div class="column col-10">
          <h5 class="mb-2">{{ $t('next_desc') }}</h5>
          <button @click="nextEw" class="btn btn btn-primary mr-2">
            <i class="icon icon-arrow-right"></i>
            {{ $t('next_ew_btn') }}
          </button>
          <button @click="nextseaLevel" class="btn btn btn-primary">
            <i class="icon icon-arrow-right"></i>
            {{ $t('next_sea_level_btn') }}
          </button>
        </div>
      </div>
      <div class="modal-footer">
        <div class="columns">
          <div class="column col-6 text-left">
            <button @click="navBack" class="btn btn-lg btn">
              <i class="icon icon-arrow-left"></i>
            </button>
          </div>
          <div class="column col-6 text-right">
            <button @click="nextAct" class="btn btn btn-success">
              <i class="icon icon-arrow-right"></i>
              {{ $t('next_act_btn') }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    nextseaLevel() {
      this.$router.push({ name: "S01-SeaLevelRiseIntro" });
    },

    nextEw() {
      this.$router.push({ name: "W01-ExtremeWeather1" });
    },

    nextAct() {
      this.$router.push({ name: "Z01-ActOverview" });
    },

    modalClose() {
      this.$parent.modalClose();
    },

    navBack() {
      this.$router.back();
    }
  }
};
</script>

<style scoped>
.effect-btn {
  width: 100%;
}
</style>
