<i18n>
{
  "de": {
    "title": "Was ist eigentlich mit Treibhauseffekt gemeint? 🔆",
    "desc_1": "Ohne Treibhausgase wäre unsere Erdoberfläche sehr kalt (etwa -18°C).",
    "desc_2": "Je mehr aber dieser Gase in der Atmosphäre sind, umso mehr Wärme wird zurückgehalten und umso mehr erwärmt sich unsere Erde.",
    "desc_3": "Eine Folge: Mehr Wasser verdunstet von den Meeren und die wärmere Atmosphäre kann mehr Wasserdampf ansammeln. Dadurch erhöht sich die Chance auf extreme Regenfälle.",
    "next_btn": "weiter"
  },
  "en": {
    "title": "What is meant by greenhouse effect? 🔆",
    "desc_1": "Without greenhouse gases the earth's surface would be very cold (around -18°C).",
    "desc_2": "But the more these gases are in the atmosphere, the more heat is retained and the more our earth warms up.",
    "desc_3": "As a consequence, more water evaporates from the seas and the warmer atmosphere can accumulate more water vapor. This increases the chance of extreme rainfall.",
    "next_btn": "Continue"
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
            <img type="image/svg+xml" class="img-responsive">
              <GreenhouseEffect :animate="true"/>
            </img>
          </div>
          <div class="column col-1 flex-centered">
            <img class="img-responsive" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
          <div class="column col-4">
            <p>{{ $t('desc_1') }}</p>
            <p>{{ $t('desc_2') }}</p>
            <p>{{ $t('desc_3') }}</p>
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
import GreenhouseEffect from '@/components/GreenhouseEffect.vue';

export default {
  components: {
    GreenhouseEffect,
  },

  methods: {
    next() {
      this.$router.push({ name: 'B03-GreenhouseEffect3' });
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

