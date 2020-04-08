<i18n>
{
  "de": {
    "title": "Wie könnte unsere Zukunft verlaufen? ",
    "desc_1": "Mit den aktuellen Klimamaßnahmen wird mit einem globalen mittleren Temperaturanstieg von mehr als 3°C bis 2100 gerechnet. Die im Paris Abkommen von 2015 vereinbarten Maßnahmen würden den Anstieg ebenfalls nicht auf weniger als 2°C beschränken. Um den Temperaturanstieg auf deutlich weniger als 2°C zu beschränken, müssten deutlich ambitioniertere Maßnahmen ergriffen werden, um die dramatischen, jetzt schon spürbaren Folgen des Klimawandels einzudämmen.",
    "legend_1": "4.1 bis 4.8°C: Prognose ohne jegliche Einschränkung der Emissionen.",
    "legend_2": "3.1 bis 3.7°C: Prognose mit den aktuell weltweit umgesetzten Maßmahmen.",
    "legend_3": "2.6 bis 3.2°C: Die Ziele aus dem Pariser Abkommen werden erreicht.",
    "legend_4": "2°C: Die Ziele aus dem Pariser Abkommen müssten übertroffen werden.",
    "legend_5": "1.5°C: Die Emissionen müssten schnell und drastisch gesenkt werden.",
    "outro": "Nutze deine Chance und setze dich jetzt für den Kampf gegen den Klimawandel und eine bessere Zukunft für uns alle ein!",
    "next_btn": "Zurück zum Start"
  },
  "en": {
    "title": "How might our future unfold?",
    "desc_1": "With the current climate policies in place, the global average temperature increase would be more than 3°C until 2100. The agreed targets of the Paris Agreement of 2015 would also not limit the temperature increase to less than 2°C. To limit the temperature increase to clearly below 2°C, more ambitious measures have to be taken to contain the dramatic, already noticeable consequences of climate change.",
    "legend_1": "4.1 to 4.8°C: Projections without any limitation of emissions.",
    "legend_2": "3.1 to 3.7°C: Projections with current global policies in place.",
    "legend_3": "2.6 to 3.2°C: The targets of the Paris Agreement are reached.",
    "legend_4": "2°C: The targets of the Paris Agreement would have to be exceeded.",
    "legend_5": "1.5°C: Emissions would have to be reduced quickly and drastically.",
    "outro": "Take your opportunity to act against climate change and secure a brighter future for us all!",
    "next_btn": "Back to Start"
  }
}
</i18n>

<template>
  <div class="modal modal-xl" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right"
           aria-label="Close"></a>

        <div class="modal-title h4">
           {{ $t("title") }}
        </div>
      </div>
      <div class="modal-body">
        <References v-if="$parent.$data.referencesActive" :references="references" />

        <div v-if="!$parent.$data.referencesActive" class="columns">
          <div class="column col-12">
            <p>{{ $t('desc_1') }}</p>
          </div>
          <div class="column col-6 col-sm-12 mb-2 d-flex align-center">
            <img class="img-responsive" v-bind:src="'/assets/future_ghg_emissions_scenarios_1990_to_2100.png'"/>
          </div>
          <div class="column col-6 col-sm-12 mb-3">
            <p>
              <ul>
                <li>{{ $t('legend_1') }}</li>
                <li>{{ $t('legend_2') }}</li>
                <li>{{ $t('legend_3') }}</li>
                <li>{{ $t('legend_4') }}</li>
                <li>{{ $t('legend_5') }}</li>
              </ul>
            </p>
          </div>
          <div class="column col-6 col-md-8 col-sm-10 col-xs-12 col-mx-auto outro">
            <img class="tutor mr-2" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
            <h4>{{ $t('outro') }}</h4>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="columns align-center">
          <div class="column col-6 text-left">
            <button @click="navBack" class="btn btn-lg btn"><i class="icon icon-arrow-left"></i></button>
              <button @click="$parent.toggleReferencesVisibility" class="btn btn-lg">
                <i
                  class="icon"
                  v-bind:class="[$parent.$data.referencesActive ? 'icon-cross' : 'icon-message']"
                ></i>
              </button>
          </div>
          <div class="column col-6 text-right">
            <button @click="next" class="btn btn-lg btn-success"> {{ $t('next_btn') }} <i class="icon icon-arrow-right"></i></button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import Vue from 'vue';
import References from '@/components/References.vue';

export default {
  components: {
    References,
  },

  data() {
    return {
      chart: new Vue(),
      year: null,
      references: [
        {
          title: 'Future greenhouse gas emission scenarios',
          version: 'TODO',
          link:
            'https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions',
          publisherName: 'Our World In Data',
          publisherLogo: '/assets/data_source_publishers/ourworldindata.png',
        },
      ],
    };
  },
  methods: {
    next() {
      this.$router.push({ name: 'A01-EntryLanguageSelect' });
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

<style scoped>
@media (min-width: 380px) {
  .outro {
    display: flex;
  }
}
.tutor {
  max-height: 100px;
  width: auto;
}
</style>
