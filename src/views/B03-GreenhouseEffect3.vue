<i18n>
{
  "de": {
    "title": "Was sind Treibhausgase und woher kommen sie?",
    "title_1": "Wo entstehen Treibhausgase?",
    "title_2": "Die wichtigsten Treibhausgase heißen",
    "bullet_1": "Kohlenstoffdioxid (CO2)",
    "bullet_2": "Methan (CH4)",
    "bullet_3": "Schwefelhexalflourid (SF6)",
    "bullet_4": "Distickstoffmonoxid (N2O)",
    "bullet_5": "Stickstofftrifluorid (NF3)",
    "bullet_6": "Fluorkohlenwasserstoffe auch FKW/HFKW",
    "bullet_desc": "Sie halten unterschiedlich stark die Sonnenwärme zurück auf der Erde: SF6 z.B. 23.500-fach stärker als CO2",
    "cause1_name": "Methan",
    "cause_1_examples": "Biogas, Rinderhlatung, Nassreisanabau",
    "cause_2_name": "Schwefelhexafluorid",
    "cause_2_examples": "Gasisolierte Schaltanlagen",
    "cause_3_name": "Distickstoffmonoxid",
    "cause_3_examples": "Stickstoffdünger",
    "cause_4_name": "Stickstofftrifluorid",
    "cause_4_examples": "Flachbildschirm, Dünnschicht-Solarzellen",
    "cause_5_name": "Kohlenstoffdioxid",
    "cause_5_examples": "Energieerzeugung, Industrie, Verkehr",
    "cause_6_name": "FKW/HFKW",
    "cause_6_examples": "Kältemittel, Klimaanlagen",
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
          <div class="column col-8">
            <h5>{{ $t('title_1') }}</h5>
          </div>
          <div class="column col-4">
            <h5>{{ $t('title_2') }}</h5>
          </div>
          <div class="column col-8">
            <div class="columns">
              <div class="column col-6">
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5">🐮 🌾 🚜 {{ $t('cause_1_name') }}</div>
                  </div>
                  <div class="card-body">
                    {{ $t('cause_1_examples') }}
                  </div>
                </div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5"> 🔌 {{ $t('cause_2_name') }}</div>
                  </div>
                  <div class="card-body">
                    {{ $t('cause_2_examples') }}
                  </div>
                  <div class="card-footer">
                    <span class="text-bold"></span>
                  </div>
                </div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5">🐄💩 {{ $t('cause_3_name') }}</div>
                  </div>
                  <div class="card-body">
                    {{ $t('cause_3_examples') }}
                  </div>
                  <div class="card-footer">
                    <span class="text-bold"></span>
                  </div>
                </div>
              </div>
              <div class="column col-6">
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5">🖥 {{ $t('cause_4_name') }}</div>
                  </div>
                  <div class="card-body">
                    {{ $t('cause_4_examples') }}
                  </div>
                </div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5">✈️ 🚍 🏭 {{ $t('cause_5_name') }}</div>
                  </div>
                  <div class="card-body">
                    {{ $t('cause_5_examples') }}
                  </div>
                  <div class="card-footer">
                    <span class="text-bold"></span>
                  </div>
                </div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5">❄️ {{ $t('cause_6_name') }}</div>
                  </div>
                  <div class="card-body">
                    {{ $t('cause_6_examples') }}
                  </div>
                  <div class="card-footer">
                    <span class="text-bold"></span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="column col-4">
            <ul>
              <li>{{ $t('bullet_1') }}</li>
              <li>{{ $t('bullet_2') }}</li>
              <li>{{ $t('bullet_3') }}</li>
              <li>{{ $t('bullet_4') }}</li>
              <li>{{ $t('bullet_5') }}</li>
              <li>{{ $t('bullet_6') }}</li>
            </ul>
            <p>{{ $t('bullet_desc') }}</p>
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
      this.$router.push({ name: 'B04-GreenhouseEffect4' });
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
