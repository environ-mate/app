<i18n>
{
  "de": {
    "title": "Wie könnte unsere Zukunft verlaufen?",
    "desc_1": "Mit den aktuellen Maßnahmen wird von einem Anstieg von mehr als 3 Grad bis 2100 im Vergleich zur vorindustriellen Zeit ausgegangen. Das Ziel des Paris Abkommens von 2015 fordert jedoch eine Beschränkung des Anstiegs auf deutlich weniger als 2 Grad, um die Konsequenzen des Klimawandels einzudämmen. Sollte dieses Ziel nicht erreicht werden, könnten die schon jetzt bemerkbaren Auswirkungen noch extremer werden.",
    "legend": "1: Für 1,5 aber auch 2°C müsste die Emissionen schnell und drastisch gesenkt werden. 2: Sollten alle Länder ihre Ziele aus dem Pariser Abkommen erreichen, wird man immer noch über den 2°C liegen. 3: Erwärmung ausgehend von der aktuell umgesetzten Klimapolitik der Länder. 4: Prognose ohne jegliche Limitierungen in den Emissionen.",
    "outro": "Nutze deine Chance und setze dich jetzt für den Kampf gegen den Klimawandel und eine bessere Zukunft für uns alle ein!",
    "next_btn": "weiter"
  },
  "en": {
    "title": "",
    "desc_1": "", 
    "legend": "",
    "outro": "",
    "next_btn": ""
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
          <div class="column col-7 flex-centered">
            <img class="img-responsive flex-end" v-bind:src="'/assets/emissions_projection_2100.png'"/> 
          </div>
          <div class="column col-4">
            <p>{{ $t('desc_1') }}</p>
            <p>{{ $t('desc_2') }}</p>
            <p>{{ $t('desc_3') }}</p>
            <p>{{ $t('desc_4') }}</p>
          </div>
          <div class="column col-1 flex-centered">
            <img class="img-responsive flex-end" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
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
      this.$router.push({ name: 'B02-GreenhouseEffect2' });
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
