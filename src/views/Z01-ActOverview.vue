<i18n>
{
  "de": {
    "title": "Was kannst du tun, um dem Klimawandel und seinen Konsequenzen entgegenzuwirken?",
    "intro": "Du hast jetzt viele Informationen zum Klimawandel, seinen Ursachen und seinen Konsequenzen erhalten. Sicher fragst du dich nun, was du als einzelne Person tun kannst, um alldem entgegenzuwirken. Hier sind ein paar Tipps, wie du deinen eigenen Beitrag für eine bessere Zukunft für uns alle leisten kannst:",
    "act_1": "Sprich mit Familie, Freunden und Bekannten über das Thema und zeig, was du über den Klimawandel gelernt hast",
    "act_2": "Gehe zur nächsten Fridays for Future Demo in deiner Nähe, um Gleichgesinnte zu treffen und dich auszutauschen:  <a class='text-break' href='https://www.fridaysforfuture.org/events/list/' target='_blank'>https://www.fridaysforfuture.org/events/list/</a>",
    "act_3": "Berechne deinen ökologischen Fußabdruck, um zu überprüfen, wie nachhaltig dein Lebensstil ist: <a class='text-break' href='https://www.footprintcalculator.org/' target='_blank'>https://www.footprintcalculator.org/</a>",
    "act_4": "Schaue dir die Tipps der EU an, was du gegen den Klimawandel tun kannst: <a class='text-break' href='https://europa.eu/euandme/passion/fighting-climate-change_en' target='_blank'>https://europa.eu/euandme/passion/fighting-climate-change_en</a>",
    "act_5": "Probiere die Zero Waste (Null Müll) Regeln aus, um dein Leben noch nachhaltiger und klimwaverträglicher zu gestalten (Button unten).",
	"act_6": "Entwickle deine eigenen Stories mit Environ-Mate und hilf dabei das Verständnis des Klimawandel zu verbessern: <a class='text-break' href='https://github.com/environ-mate/app' target='_blank'>https://github.com/environ-mate/app</a>",
    "subtitle_msg": "Die folgenden Seiten geben dir weitere Tipps.",
    "next_btn": "Null Müll Regeln",
    "next_examples": "5 Praktische Beispiele",
    "next_euact": "Weitere Infos",
    "next_future": "Unsere Zukunft"
  },
  "en": {
    "title": "What can you do to help counter climate change and its consequences?",
    "intro": "You've learnt much about the causes and consequences of climate change. But what can you, as a single person, do about all that? Here are some tips on what you can do to contribute to a better future for all",
    "act_1": "Discuss climate change with family, friends, and acquaintances to show off what you've learnt",
    "act_2": "Visit the next Fridays for Future demo in your area, to meet and collaborate with like-minded people: <a class='text-break' href='https://www.fridaysforfuture.org/events/list/' target='_blank'>https://www.fridaysforfuture.org/events/list/</a>",
    "act_3": "Calculate your ecological footprint to check how sustainable your lifestyle is: <a class='text-break' href='https://www.footprintcalculator.org/' target='_blank'>https://www.footprintcalculator.org/</a>",
    "act_4": "Check out the EU's tips for how you can help counter climate change: <a class='text-break' href='https://europa.eu/euandme/passion/fighting-climate-change_en' target='_blank'>https://europa.eu/euandme/passion/fighting-climate-change_en</a>",
    "act_5": "Try out the Zero Waste rules, to create a more sustainable and climate-friendly lifestyle: (button below)",
	"act_6": "Develop your own Stories with Environ-Mate and help improve the understanding of climate change: <a class='text-break' href='https://github.com/environ-mate/app' target='_blank'>https://github.com/environ-mate/app</a>",
	"subtitle_msg": "The following sites present further tips.",
    "next_btn": "Zero Waste Rules",
    "next_examples": "5 Practical Examples",
    "next_euact": "Further Infos",
   "next_future": "Our Future"
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
        {{ $t('intro') }}
        <div class="columns">
          <div class="column col-9 col-md-10 mb-3">
            <ul>
              <li v-html="$t('act_1')"></li>
              <li v-html="$t('act_2')"></li>
              <li v-html="$t('act_3')"></li>
              <li v-html="$t('act_4')"></li>
              <li v-html="$t('act_5')"></li>
			  <li v-html="$t('act_6')"></li>
            </ul>
          </div>
          <div class="column col-2 flex-centered mb-3">
            <img
              class="img-responsive flex-end"
              v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"
            />
          </div>
          <div class="column col-12">
            <p>{{ $t('subtitle_msg') }}</p>

            <button @click="examples" class="btn btn btn-primary mr-2 mb-2">
              {{ $t('next_examples') }}
              <i class="icon icon-arrow-right"></i>
            </button>
            <button @click="next" class="btn btn btn-primary mr-2 mb-2">
              {{ $t('next_btn') }}
              <i class="icon icon-arrow-right"></i>
            </button>
            <button @click="euact" class="btn btn btn-primary mr-2 mb-2">
              {{ $t('next_euact') }}
              <i class="icon icon-arrow-right"></i>
            </button>
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
            <button @click="future" class="btn btn-lg btn-success">
              {{ $t('next_future') }}
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
    examples() {
      this.$router.push({ name: 'Z04-ActRandom' });
    },

    next() {
      this.$router.push({ name: 'Z02-ActInfos1' });
    },

    euact() {
      this.$router.push({ name: 'Z03-ActInfos2' });
    },

    future() {
      this.$router.push({ name: 'ZXX-ActInfos3' });
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
