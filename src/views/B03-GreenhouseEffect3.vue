<i18n>
{
  "de": {
    "title": "Was sind Treibhausgase und woher kommen sie?",
    "title_1": "Wo entstehen Treibhausgase?",
    "title_2": "Die wichtigsten Treibhausgase heißen",
    "bullet_1": "Kohlenstoffdioxid (CO₂)",
    "bullet_2": "Methan (CH₄)",
    "bullet_3": "Schwefelhexaflourid (SF₆)",
    "bullet_4": "Distickstoffmonoxid (N₂O)",
    "bullet_5": "Stickstofftrifluorid (NF₃)",
    "bullet_6": "Fluorkohlenwasserstoffe (auch FKW/HFKW)",
    "bullet_desc": "Sie können die Sonnenwärme auf der Erde unterschiedlich stark zurückhalten: SF₆ z.B. 23.500-fach stärker als CO₂",
    "cause_1_name": "Kohlenstoffdioxid",
    "cause_1_examples": "Energieerzeugung, Industrie, Verkehr",
    "cause_2_name": "Methan",
    "cause_2_examples": "Biogas, Rinderhaltung, Nassreisanbau",
    "cause_3_name": "Schwefelhexafluorid",
    "cause_3_examples": "Gasisolierte Schaltanlagen",
    "cause_4_name": "Distickstoffmonoxid",
    "cause_4_examples": "Stickstoffdünger",
    "cause_5_name": "Stickstofftrifluorid",
    "cause_5_examples": "Flachbildschirm, Dünnschicht-Solarzellen",
    "cause_6_name": "FKW/HFKW",
    "cause_6_examples": "Kältemittel, Klimaanlagen",
    "next_btn": "Weiter"
  },
  "en": {
    "title": "What are greenhouse gases and where do they come from?",
    "title_1": "Where do greenhouse gases emerge?",
    "title_2": "The most important greenhouse gases are:",
    "bullet_1": "carbon dioxide (CO₂)",
    "bullet_2": "methane (CH₄)",
    "bullet_3": "sulfur hexafluoride (SF₆)",
    "bullet_4": "nitrous oxide (N₂O)",
    "bullet_5": "nitrogen trifluoride (NF₃)",
    "bullet_6": "hydrofluorocarbons (HFC)",
    "bullet_desc": "They can hold back the sun's heat on earth with varying degrees of intensity: e.g. SF₆ is 23,500 times stronger than CO₂",
    "cause_1_name": "carbon dioxide",
    "cause_1_examples": "power generation, industry, transportation",
    "cause_2_name": "methane",
    "cause_2_examples": "biogas, cattle farming, wet rice cultivation",
    "cause_3_name": "sulfur hexafluoride",
    "cause_3_examples": "gas-insulated switchgear",
    "cause_4_name": "nitrous oxide",
    "cause_4_examples": "nitrogen fertilizer",
    "cause_5_name": "nitrogen trifluoride",
    "cause_5_examples": "flat screens, thin film solar cells",
    "cause_6_name": "HFC",
    "cause_6_examples": "refrigerant, air conditioning",
    "next_btn": "Continue"
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
          <div class="column col-4 col-md-12">
            <h5>{{ $t('title_2') }}</h5>
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
          <div class="column col-8 col-md-12 mb-3">
            <h5 class="mb-3">{{ $t('title_1') }}</h5>
            <div class="columns">
              <div class="column col-6 col-sm-12">
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5">🐮 🌾 🚜 {{ $t('cause_1_name') }}</div>
                  </div>
                  <div class="card-body">{{ $t('cause_1_examples') }}</div>
                </div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5">🔌 {{ $t('cause_2_name') }}</div>
                  </div>
                  <div class="card-body">{{ $t('cause_2_examples') }}</div>
                  <div class="card-footer">
                    <span class="text-bold"></span>
                  </div>
                </div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5">🐄💩 {{ $t('cause_3_name') }}</div>
                  </div>
                  <div class="card-body">{{ $t('cause_3_examples') }}</div>
                  <div class="card-footer">
                    <span class="text-bold"></span>
                  </div>
                </div>
              </div>
              <div class="column col-6 col-sm-12">
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5">🖥 {{ $t('cause_4_name') }}</div>
                  </div>
                  <div class="card-body">{{ $t('cause_4_examples') }}</div>
                </div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5">✈️ 🚍 🏭 {{ $t('cause_5_name') }}</div>
                  </div>
                  <div class="card-body">{{ $t('cause_5_examples') }}</div>
                  <div class="card-footer">
                    <span class="text-bold"></span>
                  </div>
                </div>
                <div class="card">
                  <div class="card-header">
                    <div class="card-title h5">❄️ {{ $t('cause_6_name') }}</div>
                  </div>
                  <div class="card-body">{{ $t('cause_6_examples') }}</div>
                  <div class="card-footer">
                    <span class="text-bold"></span>
                  </div>
                </div>
              </div>
            </div>
          </div>
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
