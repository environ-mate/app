<i18n>
{
  "de": {
    "title": "Was ist eigentlich mit Treibhauseffekt gemeint? 🔆",
    "desc_1": "Um die Erde ist eine Lufthülle, die man Atmosphäre nennt. Diese besteht zu über 98% aus Sauerstoff und Stickstoff.",
    "desc_2": "Sonnenstrahlen scheinen auf die Erde, die Erde erwärmt sich und ein Teil der Strahlung wird von der Erde zurückgeworfen. Einen Teil davon hält die Atmosphäre auf und wirft sie erneut auf die Erde, der andere Teil entweicht ins Weltall.",
    "desc_3": "Bestimmte Gase (wie CO₂) in der Atmosphäre sind für diesen Effekt verantwortlich.",
    "desc_4": "Der ganze Prozess ist ähnlich wie in einem Gewächshaus (Treibhaus) und deshalb nennt man diese Gase auch Treibhausgase.",
    "next_btn": "weiter"
  },
  "en": {
    "title": "What is meant by the greenhouse effect? 🔆",
    "desc_1": "Around the earth is an air-envelope called the atmosphere. This consists of over 98% oxygen and nitrogen.",
    "desc_2": "Sunlight hits the earth, warming the ground, and some of this radiation is thrown back into space. Part of this is then stopped by the atmosphere and bounced back at the earth.",
    "desc_3": "Certain gases (like CO₂) in the atmosphere are responsible for this effect.",
    "desc_4": "The overall process is much like in a greenhouse. This is why the gases are called greenhouse gases.",
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
          <div class="column col-7 col-sm-12 mb-3">
            <GreenhouseEffect />
          </div>
          <div class="column col-4 col-sm-10">
            <p>{{ $t('desc_1') }}</p>
            <p>{{ $t('desc_2') }}</p>
            <p>{{ $t('desc_3') }}</p>
            <p>{{ $t('desc_4') }}</p>
          </div>
          <div class="column col-1 col-sm-2 d-flex">
            <img
              class="img-responsive flex-end mb-3"
              v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"
            />
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="columns align-center">
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
import GreenhouseEffect from "@/components/GreenhouseEffect.vue";

export default {
  components: {
    GreenhouseEffect
  },

  methods: {
    next() {
      this.$router.push({ name: "B02-GreenhouseEffect2" });
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
