<i18n>
{
  "de": {
    "title": "Zero Waste - Null Müll Regeln",
    "rule_1": "<strong>Verzichte</strong> auf Dinge, die du nicht wirklich benötigst. Frage dich vor einer neuen Anschaffung, ob du sie wirklich brauchst und wie lange sie für dich nützlich sein wird.",
    "rule_2": "<strong>Reduziere</strong>, was du brauchst. Sieh dich zu Hause und in deinem Alltag um und finde Dinge, die du nicht wirklich brauchst oder mehrfach besitzt. Spende oder verkaufe diese Dinge.",
    "rule_3": "<strong>Nutze wiederverwendbare</strong> Dinge. Vermeide Einwegartikel und versuche, sie in deinem Alltag mit langlebigen Alternativen zu ersetzen oder zumindest Alternativen, die z.B. kompostierbar sind.",
    "rule_4": "<strong>Recycle</strong>, was du nicht mit den ersten drei Regeln vermeiden kannst. Informiere dich, wie in deiner Gegend Müll getrennt wird und halte dich an diese Regeln.",
    "rule_5": "<strong>Kompostiere</strong> den Rest. Mit den obigen Regeln sollte der Großteil des Mülls behandelt worden sein. Was jetzt noch übrig ist, sollten Essenreste und andere kompostierbare Abfälle sein.",
    "act_1": "Verzichten",
    "act_2": "Reduzieren",
    "act_3": "Wiederverwenden",
    "act_4": "Wiederverwerten",
    "act_5": "Kompostieren",
   "subtitle_msg": "Versuch dir diese Regeln zu merken und sie in deinen Alltag anzuwenden.",
   "next_btn": "Übersicht Auswirkungen",
   "next_examples": "Übersicht Handeln"
  },
  "en": {
    "title": "Zero Waste Rules",
    "rule_1": "<strong>Refuse</strong> what you do not need. Ask yourself if you really need it before buying and how long it will actually be useful to you.",
    "rule_2": "<strong>Reduce</strong> what you do need. Examine your home and lifestyle to identify things that you do not actually need such as duplicates or unused items in the kitchen or wardrobe. Donate the extra items to secondhand stores or sell online!",
    "rule_3": "<strong>Reuse</strong> by using reusables. Avoid single-use items with long-lasting alternatives that either A) will last into a foreseeable future (think stainless steel or glass) or B) are compostable.",
    "rule_4": "<strong>Recycle</strong> what you cannot refuse, reduce or reuse. Research your local recycling policies and follow their rules.",
    "rule_5": "<strong>Rot</strong> (a.k.a. compost the rest). At this point, you should have taken care of the vast majority of your waste. All that’s left should in theory be food waste and compostable scraps.",
    "act_1": "REFUSE",
    "act_2": "REDUCE",
    "act_3": "REUSE",
    "act_4": "RECYCLE",
    "act_5": "ROT",
   "subtitle_msg": "Try to keep these rules in mind and to apply them in your everyday life.",
   "next_btn": "Overview Consequences",
   "next_examples": "Overview Actions"
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
          <div class="column col-3 col-sm-5 col-xs-6">
            <ol>
              <li>{{ $t('act_1') }}</li>
              <li>{{ $t('act_2') }}</li>
              <li>{{ $t('act_3') }}</li>
              <li>{{ $t('act_4') }}</li>
              <li>{{ $t('act_5') }}</li>
            </ol>
          </div>
          <div class="column col-2 col-sm-3 col-xs-4">
            <img
              class="img-responsive mt-2"
              v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"
            />
          </div>
          <div class="column col-7 col-sm-12 mb-2">
            <ul>
              <li v-html="$t('rule_1')" />
              <li v-html="$t('rule_2')" />
              <li v-html="$t('rule_3')" />
              <li v-html="$t('rule_4')" />
              <li v-html="$t('rule_5')" />
            </ul>
          </div>
          <div class="column col-12">
            <p>{{ $t('subtitle_msg') }}</p>
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
      this.$router.push({ name: "C01-ClimateChangeEffectsIntro" });
    },

    examples() {
      this.$router.push({ name: "Z01-ActOverview" });
    },

    modalClose() {
      this.$parent.modalClose();
    },

    navBack() {
      this.$router.back();
    }
  }
};
</script>
