<i18n>
{
  "de": {
    "title": "Zero Waste - Null Müll Regeln",
    "rule_1": "Verzichte auf Dinge die du nicht wirklich benötigst. Frage dich vor einer neuen Anschaffung ob du sie wirklich brauchst und wie lange sie für dich nützlich sein wird.",
    "rule_2": "Reduziere was du brauchst. Sehe dich zu Hause um und in deinem Alltag und finde Dinge, die nicht wirklich brauchst oder du mehrfach besitzt. Spende oder verkaufe diese Dinge.",
    "rule_3": "Nutze wiederverwendbare Dinge. Vermeide Einwegartikel und versuche sie in deinem Alltag mit langlebigen Alternativen zu ersetzen oder zumindest Alternativen die z.B. kompostierbar sind.",
    "rule_4": "Recycle was du nicht mit den ersten drei Regeln vermeiden kannst. Informiere dich wie in deiner Gegend Müll getrennt wird und halte dich an diese Regeln.",
    "rule_5": "Kompostiere den Rest. Mit den obigen Regeln sollte der Großteil des Mülls behandelt worden sein. Was jetzt noch übrig ist, sollten Essenreste und andere kompostierbare Abfälle sein.",
    "act_1": "#1 Verzichten",
    "act_2": "#2 Reduzieren",
    "act_3": "#3 Wiederverwenden",
    "act_4": "#4 Wiederverwerten",
    "act_5": "#5 Kompostieren",
   "subtitle_msg": "Versuch dir diese Regeln zu merken und sie in deinen Alltag anzuwenden.",
   "next_btn": "Wähle eine andere Stadt",
   "next_examples": "Zurück zur Übersicht"
  },
  "en": {
    "title": "Zero Waste Rules",
    "rule_1": "Refuse what you do not need. Ask yourself if you really need it before buying and how long it will actually be useful to you.",
    "rule_2": "Reduce what you do need. Examine your home and lifestyle to identify things that you do not actually need such as duplicates or unused items in the kitchen or wardrobe. Donate the extra items to secondhand stores or sell online!",
    "rule_3": "Reuse by using reusables. Avoid single-use items with long-lasting alternatives that either A) will last into a foreseeable forever (think stainless steel or glass) or B) will effectively disappear into the Earth with time.",
    "rule_4": "Recycle what you cannot refuse, reduce or reuse. Research your local recycling policies and follow their rules.",
    "rule_5": "Rot (a.k.a. compost the rest). At this point, you should have taken care of the vast majority of your waste. All that’s left should in theory be food waste and compostable scraps.",
    "act_1": "#1 REFUSE",
    "act_2": "#2 REDUCE",
    "act_3": "#3 REUSE",
    "act_4": "#4 RECYCLE",
    "act_5": "#5 ROT",
   "subtitle_msg": "Try to keep these rules in mind and to apply them in your everyday life.",
   "next_btn": "Select a different city",
   "next_examples": "Back to Overview"
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
          <div class="column col-2 flex-centered">
            <img class="img-responsive flex-end" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
          <div class="column col-7">
            <ul>
              <li>{{ $t('rule_1') }}</li>
              <li>{{ $t('rule_2') }}</li>
              <li>{{ $t('rule_3') }}</li>
              <li>{{ $t('rule_4') }}</li>
              <li>{{ $t('rule_5') }}</li>
            </ul>
          </div>
          <div class="column col-3">
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
      <div  class="column col-12">
        <p>{{ $t('subtitle_msg') }}</p>
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
