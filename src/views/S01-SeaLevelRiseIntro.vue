<i18n>
{
  "de": {
    "title": "Was passiert eigentlich beim Anstieg des Meeresspiegels?",
    "title_direct": "Es gibt drei Auswirkungen der Erderwärmung die den Anstieg überwiegend verursachen:",
    "title_indirect": "Auswirkungen auf unser Leben",
    "cause_direct_1": "Wärmeausdehnung: Warmes wasser dehnt sich weiter aus. Die Hälfte des Anstiegs in den letzten 25 Jahren geht auf diesen Effekt zurück.",
    "cause_direct_2": "Abschmelzen der Gletscher: Durch kürzere und wärmere Winter können sich die Gletcher nicht mehr regenerieren und schmilzen nach und nach ab. Das Wasser fließt ins Meer ab.",
    "cause_direct_3": "Abschmelzen der Eisschichten über Grönland und der Antarktis: Wie bei den Gletschern nehmen die Eisschichten in diesen Regionen sichtlich ab und geben das Wasser ins Meer ab.",
    "effect_direct_1": "Hochwasser",
    "effect_direct_2": "Hurricanes/Typhune und Starkregen",
    "effect_direct_3": "...",
    "subtitle_msg": "Der Anstieg des Meeresspiegels mag mit etwa 70cm bis 2100 gering wirken aber die Auswirkungen fallen regional äusserst unterschiedlich aus und wie sich der Anstieg über die kommenden Jahre beschleunigt kann man nicht exakt vorhersagen.",
    "next_btn": "weiter"
  },
  "en": {
    "title": "What happens when the sea rises?",
    "title_direct": "Direct consequences",
    "title_indirect": "Indirect consequences",
    "cause_direct_1": "Rising temperatures",
    "cause_direct_2": "Changes in amount and frequency of rainfall",
    "cause_direct_3": "More frequent droughts and heatwaves",
    "effect_direct_1": "Rising temperatures",
    "effect_direct_2": "Changes in amount and frequency of rainfall",
    "effect_direct_3": "More frequent droughts and heatwaves",
    "subtitle_msg": "A rise in sea level of around 70cm by 2100 might not sound like much, but the potential outcomes vary widely between different regions and it is difficult to predict how the sea level rise will accelerate in coming years.",
    "next_btn": "continue"
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
           {{ $t("title") }} 🌊
        </div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-2 flex-centered">
            <img class="img-responsive flex-end" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
          <div class="column col-5">
            <h5>{{ $t('title_direct') }}</h5>
            <ul>
              <li>{{ $t('cause_direct_1') }}</li>
              <li>{{ $t('cause_direct_2') }}</li>
              <li>{{ $t('cause_direct_3') }}</li>
            </ul>
          </div>
          <div class="column col-5">
            <h5>{{ $t('title_indirect') }}</h5>
            <ul>
              <li>{{ $t('effect_direct_1') }}</li>
              <li>{{ $t('effect_direct_2') }}</li>
              <li>{{ $t('effect_direct_3') }}</li>
            </ul>
          </div>
          <div class="column col-12">
            <p>{{ $t('subtitle_msg') }}</p>
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
      this.$router.push({ name: 'S02-SeaLevelRiseStory' });
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
