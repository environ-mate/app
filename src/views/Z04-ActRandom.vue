<i18n>
{
  "de": {
    "title": "5 praktische Tipps für deinen Alltag",
    "intro": "Viele (auch kleine) Schritte bringen uns unserem Ziel näher, unsere Emissionen zu reduzieren. Stecke dir neue Ziele und überlege, womit du anfangen kannst. Hier sind ein paar einfache Tipps:",
    "act_1": "Weniger Tierprodukte - Rinderhaltung und Tierzucht sind schlecht für das Klima. Versuche daher auf Fleisch- und Milchprodukte zu verzichten.",
    "act_2": "Mülltrennung - Versuche immer, Müll zu vermeiden, aber wenn Müll anfällt, dann trenne ihn, damit er recyclet werden kann.",
    "act_3": "Pappe-lapapp! - Verzichte auf Getränkebecher aus Pappe. Nimm dir lieber ein Getränk in einer wiederverschließbaren Flasche von Zuhause mit.",
    "act_4": "Tritt in die Pedale! - Nimm lieber das Rad, anstatt Bus oder Auto. Hält fit und schont die Umwelt.",
    "act_5": "Stoßlüften - Im Winter regelmäßig alle Fenster öffnen und nicht die Fenster längere Zeit gekippt lassen.",
   "next_btn": "Übersicht Auswirkungen",
   "next_examples": "Übersicht Handeln"
  },
  "en": {
    "title": "5 practical pieces of advice for your everyday life",
    "intro": "Many (even small) steps bring us closer to our goal of reducing emissions. Set yourself goals and figure out where to start. Here are some simple tips:",
    "act_1": "Fewer animal products - cattle and livestock farming harms the climate. Try to avoid meat and dairy products.",
    "act_2": "Waste separation - avoid creating waste where possible. When this is unavoidable, make sure to seperate it so that it can be recycled.",
    "act_3": "Avoid disposable paper cups - it's better to enjoy a drink from your own, reusable cup or bottle.",
    "act_4": "Cycle! It's better to use a bicycle than a bus or a car to get to places. It's good for both you AND the environment. Win-win!",
    "act_5": "Smarter ventilation - in winter, if your home gets a bit too warm, it's better to briefly open all your windows wide than to keep them continuously open.",
    "next_btn": "Overview of Consequences",
   "next_examples": "Overview of Actions"
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
        {{ $t('intro') }}
        <div class="columns">
          <div class="column col-7 col-md-10 col-xs-12">
            <ul>
              <li>{{ $t('act_1') }}</li>
              <li>{{ $t('act_2') }}</li>
              <li>{{ $t('act_3') }}</li>
              <li>{{ $t('act_4') }}</li>
              <li>{{ $t('act_5') }}</li>
            </ul>
          </div>
          <div class="column col-2 col-xs-5">
            <img
              class="img-responsive"
              v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"
            />
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="columns align-center">
          <div class="column col-3 text-left">
            <button @click="navBack" class="btn btn-lg btn">
              <i class="icon icon-arrow-left"></i>
            </button>
          </div>
          <div class="column col-9 text-right">
            <button @click="examples" class="btn btn btn-success mb-1">
              {{ $t('next_examples') }}
              <i class="icon icon-arrow-right"></i>
            </button>
            <button @click="next" class="btn btn-success btn-multiline ml-2 mb-1">
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
      this.$router.push({ name: 'C01-ClimateChangeEffectsIntro' });
    },

    examples() {
      this.$router.push({ name: 'Z01-ActOverview' });
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
