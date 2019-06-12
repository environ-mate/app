<i18n>
{
  "de": {
    "title": "Wie könnte unsere Zukunft verlaufen? ",
    "desc_1": "Mit den aktuellen Maßnahmen wird von einem Anstieg von mehr als 3 Grad bis 2100 im Vergleich zur vorindustriellen Zeit ausgegangen. Das Ziel des Paris Abkommens von 2015 fordert jedoch eine Beschränkung des Anstiegs auf deutlich weniger als 2 Grad, um die Konsequenzen des Klimawandels einzudämmen. Sollte dieses Ziel nicht erreicht werden, könnten die schon jetzt bemerkbaren Auswirkungen noch extremer werden.",
    "legend_1": "1,5 bis 2°C Emissionen müssten schnell und drastisch gesenkt werden.",
    "legend_2": "Ziele aus dem Pariser Abkommen erreicht (Vorhersage über den angestrebten 2°C).",
    "legend_3": "Erwärmung mit der aktuell umgesetzten Klimapolitik der Länder.",
    "legend_4": "Prognose ohne jegliche Limitierungen in den Emissionen.",
    "outro": "Nutze deine Chance und setze dich jetzt für den Kampf gegen den Klimawandel und eine bessere Zukunft für uns alle ein!",
    "next_btn": "zum Start"
  },
  "en": {
    "title": "How might our future unfold?",
    "desc_1": "With current efforts against climate change we expect a rise in global temperatures of 3° Celsius above pre-industrial levels by 2100. The Paris Agreement of 2015 however aims to reduce the temperature rise to below 2°C in order to mitigate the consequences of climate change. If this target is not reached, the already noticeable effects today could get considerably worse.",
    "legend_1": "1.5 to 2°C emissions would have to be drastically and rapidly reduced. 2:  3:  4: ",
    "legend_2": "Targets of the Paris Agreement achieved (prediction over the targeted 2°C).",
    "legend_3": "Warming with current climate policies.",
    "legend_4": "Prediction for no limitations on emissions.s",
    "outro": "Take your opportunity to act against climate change and secure a brighter future for us all!",
    "next_btn": "to start"
  }
}
</i18n>

<template>
  <div class="modal modal-xl" v-bind:class="{ active: this.$parent.$data.modalOpen }">
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
          <div class="column col-12">
            <p>{{ $t('desc_1') }}</p>
          </div>

          <div class="column col-6 flex-centered">
            <img class="img-responsive" v-bind:src="'/assets/emissions_projection_2100.png'"/>
          </div>
          <div class="column col-6">
            <p>
              <ul>
                <li>{{ $t('legend_1') }}</li>
                <li>{{ $t('legend_2') }}</li>
                <li>{{ $t('legend_3') }}</li>
                <li>{{ $t('legend_4') }}</li>
              </ul>
            </p>

            <br/>
            <div class="columns">
              <div class="column col-1">
              </div>
              <div class="column col-2">
                <img class="tutor" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
              </div>
              <div class="column col-9 flex-centered">
                <h4>{{ $t('outro') }}</h4>
              </div>
            </div>

          </div>
        </div>
      </div>
      <div class="modal-footer">
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
  .tutor {
    max-height: 100px;
    width: auto;
  }
</style>
