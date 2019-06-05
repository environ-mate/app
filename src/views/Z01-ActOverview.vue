<i18n>
{
  "de": {
    "title": "Was kannst du tun, um dem Klimawandel und seinen Konsequenzen entgegenzuwirken?",
    "intro": "Du hast jetzt viele Informationen zum Klimawandel, seinen Ursachen und seinen Konsequenzen erhalten. Sicher fragst du dich nun, was du als einzelne Person tun kannst, um alldem entgegenzuwirken. Hier sind ein paar Tipps, wie du deinen eigenen Beitrag für eine bessere Zukunft für uns alle leisten kannst", 
   "act_1": "Sprich mit Familie, Freunden und Bekannten über das Thema und zeig, was du über den Klimawandel gelernt hast",
    "act_2": "Gehe zur nächsten Fridays for Future Demo in deiner Nähe, um Gleichgesinnte zu treffen und dich auszutauschen: https://www.fridaysforfuture.org/events/list",
    "act_3": "Berechne deinen ökologischen Fußabdruck, um zu überprüfen, wie nachhaltig dein Lebensstil ist: https://www.footprintcalculator.org/",
    "act_4": "Schaue dir die Tipps der EU an, was du gegen den Klimawandel tun kannst: https://europa.eu/euandme/passion/fighting-climate-change_en",
    "act_5": "Probiere die Zero Waste (Null Müll) Regeln aus, um dein Leben noch nachhaltiger und klimwaverträglicher zu gestalten (Link unterhalb).",
   "subtitle_msg": "Die folgenden Seiten geben dir noch weitere Tipps.",
   "next_btn": "Null Müll Regeln",
   "next_examples": "5 Praktische Beispiele",
   "next_euact": "Weitere Infos"
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
      <div  class="column col-12">
        <p>{{ $t('subtitle_msg') }}</p>
      </div>
      <div class="modal-footer">
       <div class="columns">
          <div class="column col-1 flex-centered">
            <button @click="navBack" class="btn btn-lg btn float-left"><i class="icon icon-arrow-left"></i></button>
          </div>
          <div class="column col-2 flex-centered">
          </div>
         <div class="column col-3 flex-centered">
            <button @click="examples" class="btn btn-lg btn-success float-right"> {{ $t('next_examples') }}<i class="icon icon-arrow-right"></i></button>
          </div>
          <div class="column col-3 flex-centered">
            <button @click="next" class="btn btn-lg btn-success float-right"> {{ $t('next_btn') }}<i class="icon icon-arrow-right"></i></button>
          </div>
          <div class="column col-3 flex-centered">
            <button @click="euact" class="btn btn-lg btn-success float-right"> {{ $t('next_euact') }}<i class="icon icon-arrow-right"></i></button>
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

    modalClose() {
      this.$parent.modalClose();
    },

    navBack() {
      this.$router.back();
    },
  },
};
</script>
