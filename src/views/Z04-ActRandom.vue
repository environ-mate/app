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
    "act_1": "tipp1",
    "act_2": "tipp2",
    "act_3": "tipp3",
    "act_4": "tipp4",
    "act_5": "tipp5",
    "next_btn": "Overview Consequences",
   "next_examples": "Overview Actions"
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
        {{ $t('intro') }}
        <div class="columns">
          <div class="column col-2 flex-centered">
            <img class="img-responsive flex-end" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
          <div class="column col-7">
            <ul>
              <li>{{ $t('act_1') }}</li>
              <li>{{ $t('act_2') }}</li>
              <li>{{ $t('act_3') }}</li>
              <li>{{ $t('act_4') }}</li>
              <li>{{ $t('act_5') }}</li>
            </ul>
          </div>
        </div>
      </div>
      <div class="modal-footer">
       <div class="columns">
          <div class="column col-1 flex-centered">
            <button @click="navBack" class="btn btn btn float-left"><i class="icon icon-arrow-left"></i></button>
          </div>
          <div class="column col-5 flex-centered">
          </div>
          <div class="column col-3 flex-centered">
            <button @click="examples" class="btn btn btn-success float-right"> {{ $t('next_examples') }}<i class="icon icon-arrow-right"></i></button>
          </div>
          <div class="column col-3 flex-centered">
            <button @click="next" class="btn btn btn-success float-right"> {{ $t('next_btn') }}<i class="icon icon-arrow-right"></i></button>
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
