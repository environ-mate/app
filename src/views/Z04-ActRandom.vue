<i18n>
{
  "de": {
    "title": "5 praktische Tipps für deinen Alltag",
    "intro": "Viele (auch kleine) Schritte bringen uns unserem Ziel näher unsere Emissionen zu reduzieren. Stecke dir neue Ziele und überlege womit du anfangen kannst. Hier sind ein paar einfache Tipps:",
    "act_1": "tipp1",
    "act_2": "tipp2",
    "act_3": "tipp3",
    "act_4": "tipp4",
    "act_5": "tipp5",
   "next_btn": "Zurück zur Übersicht"
  },
  "en": {
    "title": "5 practical advices for your everyday life",
    "intro": "Many (even small) steps bring us closer to our goal to reduce emissions. Set yourself goals and figure out where to start. Here are some simple advices:",
    "act_1": "tipp1",
    "act_2": "tipp2",
    "act_3": "tipp3",
    "act_4": "tipp4",
    "act_5": "tipp5",
   "next_btn": "Back to Overview"
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
      this.$router.push({ name: 'Z01-ActOverview'});
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
