<i18n>
{
  "de": {
    "title": "Was passiert eigentlich beim Anstieg des Meeresspiegels?",
    "title_direct": "Es gibt drei Auswirkungen der Erderwärmung, die den Anstieg überwiegend verursachen:",
    "cause_direct_1": "Wärmeausdehnung: Warmes Wasser dehnt sich weiter aus. Die Hälfte des Anstiegs in den letzten 25 Jahren geht auf diesen Effekt zurück.",
    "cause_direct_2": "Abschmelzen der Gletscher: Durch kürzere und wärmere Winter können sich die Gletscher nicht mehr regenerieren und schmelzen nach und nach ab. Das Wasser fließt ins Meer ab.",
    "cause_direct_3": "Abschmelzen der Eisschichten über Grönland und der Antarktis: Wie bei den Gletschern nehmen die Eisschichten in diesen Regionen sichtlich ab und geben das Wasser ins Meer ab.",
    "subtitle_msg": "Der Anstieg des Meeresspiegels mag mit etwa 70cm bis 2100 gering wirken, aber die Auswirkungen fallen regional äußerst unterschiedlich aus. Wie sich der Anstieg über die kommenden Jahre beschleunigt, kann man nicht exakt vorhersagen. Jedoch sehen wir bereits jetzt, wie sich Hochwasser, Hurricanes (Wirbelstürme) und Starkregen häufen.",
    "next_btn": "weiter"
  },
  "en": {
    "title": "What happens when the sea rises?",
    "title_direct": "Rising sea levels are mainly due to three effects of climate change:",
    "cause_direct_1": "Thermal expansion: warmer water expands. Half of the sea level rise seen in the last 25 years is due to this effect.",
    "cause_direct_2": "Glacial melting: With shorter and warmer winters glaciers aren't able to regenerate themselves and gradually melt, adding more water to the oceans.",
    "cause_direct_3": "Melting of the ice sheets in Greenland and Antarctica: as with the glaciers, these ice sheets are noticeably shrinking and contributing to the global sea level.",
    "subtitle_msg": "A rise in sea level of around 70cm by 2100 might not sound like much, but the potential outcomes vary widely between different regions and it is difficult to predict how the sea level rise will accelerate in coming years. However, even now we're starting to see more frequent and devastating instances of floods, hurricanes and heavier rainfall.",
    "next_btn": "Continue"
  }
}
</i18n>

<template>
  <div class="modal modal-xl" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right" aria-label="Close"></a>

        <div class="modal-title h4">{{ $t("title") }} 🌊</div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-10 col-xs-12 mb-2">
            <h5>{{ $t('title_direct') }}</h5>
            <ul>
              <li>{{ $t('cause_direct_1') }}</li>
              <li>{{ $t('cause_direct_2') }}</li>
              <li>{{ $t('cause_direct_3') }}</li>
            </ul>
          </div>
          <div class="column col-2 col-xs-5 d-flex mb-2">
            <img
              class="img-responsive flex-end"
              v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"
            />
          </div>
          <div class="column col-12">
            <p>{{ $t('subtitle_msg') }}</p>
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
