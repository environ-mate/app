<i18n>
{
  "de": {
    "title": "Weitere Infos zum Klimawandel und der Rolle der EU",
    "intro": "Wenn du noch mehr über den Klimawandel und darüber, was die EU gegen ihn tut, lernen möchtest, empfehlen wir dir folgende Seiten einmal anzuschauen. Offene Daten bilden zudem das Herzstücks unserer Projekts und helfen dabei, den Klimawandel besser zu verstehen - im offenen Datenportal der EU findest du viele interessante Datensätze und Visualisierungen rund um dem Klimawandel:",
    "act_1": "<a href='https://www.ipcc.ch/' target='_blank'>Intergovernmental Panel on Climate Change ('Weltklimarat')</a>",
    "act_2": "<a href='https://www.ipbes.net/' target='_blank'>Intergovernmental Platform on Biodiversity and Ecosystem Services ('Weltbiodiversitätsrat')</a>",
    "act_3": "<a href='https://ec.europa.eu/clima/index_de' target='_blank'>Klimapolitik der EU</a>",
    "act_4": "<a href='https://www.eea.europa.eu/deEuropäische' target='_blank'>Umweltagentur</a>",
    "act_5": "<a href='https://data.europa.eu/euodp/de/data/' target='_blank'>Offenes Datenportal der EU</a>",
   "next_btn": "Wähle eine andere Stadt",
   "next_examples": "Zurück zur Übersicht"
  },
  "en": {
    "title": "Further information regarding climate change and the role of the EU",
    "intro": "If you want to know more about climate change and what the EU is doing to counter it, we recommend looking at the following sites. Open datasets are the core of our project and help us better understand climate change - in the EU Open Data Portal you'll find many interesting datasets and visualisations concerning climate change.",
    "act_1": "<a href='https://www.ipcc.ch/' target='_blank'>Intergovernmental Panel on Climate Change</a>",
    "act_2": "<a href='https://www.ipbes.net/' target='_blank'>Intergovernmental Platform on Biodiversity and Ecosystem Services</a>",
    "act_3": "<a href='https://ec.europa.eu/clima/index_de' target='_blank'>EU climate action</a>",
    "act_4": "<a href='https://www.eea.europa.eu/deEuropäische' target='_blank'>European Environmental Agency</a>",
        "act_5": "<a href='https://data.europa.eu/euodp/de/data/' target='_blank'>EU Open Data Portal</a>",
   "next_btn": "Choose another city",
   "next_examples": "Back to Overview"
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
              <li v-html="$t('act_1')"></li>
              <li v-html="$t('act_2')"></li>
              <li v-html="$t('act_3')"></li>
              <li v-html="$t('act_4')"></li>
              <li v-html="$t('act_5')"></li>
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
