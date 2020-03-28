<i18n>
{
  "de": {
    "title": "Welche Geschichten stehen hinter den Auswirkungen?",
    "story_one": "Flucht",
    "story_two": "Zukunftsängste",
    "story_three": "Hitzewellen",
    "effect_direct_2": "Änderung der Regenmenge und -häufigkeit (u.a. Starkregen)",
    "effect_direct_3": "Häufigere Dürre- und Hitzeperioden",
    "effect_direct_4": "Wirbelstürme wie Hurricanes treten häufiger und stärker auf (Tornados in Europa)",
    "next_btn": "weiter"
  },
  "en": {
    "title": "What stories do the outcomes tell?",
    "story_one": "Migration",
    "story_two": "Anxiety over the future",
    "story_three": "Heatwaves",
    "effect_direct_2": "Changes in amount and frequency of rainfall",
    "effect_direct_3": "More frequent droughts and heatwaves",
    "effect_direct_4": "Major storms such as Hurricanes become more frequent and more severe (tornadoes in Europe)",
    "next_btn": "Continue"
  }
}
</i18n>

<template>
  <div class="modal modal-lg" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right" aria-label="Close"></a>

        <div class="modal-title h4">{{ $t("title") }}</div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-2 flex-centered">
            <img
              class="img-responsive flex-end"
              v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"
            />
          </div>
          <div class="column col-3">
            <h5>{{ $t('story_one') }}</h5>
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
          <div class="column col-3">
            <h5>{{ $t('story_two') }}</h5>
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
          <div class="story_three">
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
      <div class="column col-12">
        <p>{{ $t('subtitle_msg') }}</p>
      </div>
      <div class="modal-footer">
        <div class="columns">
          <div class="column col-6 text-left">
            <button @click="navBack" class="btn btn-lg btn">
              <i class="icon icon-arrow-left"></i>
            </button>
          </div>
          <div class="column col-6 text-right">
            <button @click="next" class="btn btn-lg btn-success">
              {{ $t('next_btn') }}
              <i class="icon icon-arrow-right"></i>
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
    next() {
      this.$router.push({ name: 'S01-SeaLevelRiseIntro' });
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
