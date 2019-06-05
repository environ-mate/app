<i18n>
{
  "de": {
    "title": "Weitere Infos zum Klimawandel und der Rolle der EU",
    "intro": "Wenn du noch mehr über den Klimawandel und darüber, was die EU gegen ihn tut, lernen möchtest, empfehlen wir dir folgende Seiten einmal anzuschauen. Offene Daten bilden zudem das Herzstücks unserer Projekts und helfen dabei, den Klimawandel besser zu verstehen - im offenen Datenportal der EU findest du viele interessante Datensätze und Visualisierungen rund um dem Klimawandel:",
    "act_1": "Intergovernmental Panel on Climate Change ('Weltklimarat'): https://www.ipcc.ch/",
    "act_2": "Intergovernmental Platform on Biodiversity and Ecosystem Services ('Weltbiodiversitätsrat'): https://www.ipbes.net/",
    "act_3": "Klimapolitik der EU: https://ec.europa.eu/clima/index_de",
    "act_4": "Europäische Umweltagentur: https://www.eea.europa.eu/de",
    "act_5": "Offenes Datenportal der EU: https://data.europa.eu/euodp/de/data/",
   "next_btn": "Wähle eine andere Stadt",
   "next_examples": "Zurück zur Übersicht"
  },
  "en": {
    "title": "Further information refarding climate change and the role of the EU",
    "intro": "If you want to know more about climate change and what the EU is doing to counter it, we recommend looking at the following sites. Open datasets are the core of our project and help us better understand climate change - in the EU Open Data Portal you'll find many interesting datasets and visualisations concerning climate change:",
    "act_1": "Intergovernmental Panel on Climate Change: https://www.ipcc.ch/",
    "act_2": "Intergovernmental Platform on Biodiversity and Ecosystem Services: https://www.ipbes.net/",
    "act_3": "EU climate action: https://ec.europa.eu/clima/index_de",
    "act_4": "European Environmental Agency: https://www.eea.europa.eu/de",
    "act_5": "EU Open Data Portal: https://data.europa.eu/euodp/de/data/",
   "next_btn": "Choose another city",
   "next_examples": "Back to overview"
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
            <button @click="navBack" class="btn btn-lg btn float-left"><i class="icon icon-arrow-left"></i></button>
          </div>
          <div class="column col-5 flex-centered">
          </div>          
          <div class="column col-3 flex-centered">
            <button @click="examples" class="btn btn-lg btn-success float-right"> {{ $t('next_examples') }}<i class="icon icon-arrow-right"></i></button>
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
      this.$router.push({ name: 'A03-EntryHomeTownSelect' });
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
