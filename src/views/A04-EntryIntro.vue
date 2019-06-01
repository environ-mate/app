<i18n>
{
  "de": {
    "title": "Klimawandel, was ist das eigentlich?",
    "intro_1": "Du hast sicher schon mal vom Klimawandel gehört. Was hat es damit eigentlich auf sich?",
    "intro_2": "In den letzten Jahrzehnten hat sich die Durchschnittstemperatur auf unserer Erde drastisch erhöht. 1-2 Grad hören sich dabei wenig an, haben aber einen großen Effekt auf unsere Umwelt.",
    "chart_degress_desc": "Schaut man sich die Durchschnittstemperaturen in Europa im Vergleich zur vorindustriellen Zeit an, sieht man wie gerade die letzten Jahre immer wärmer wurden:",
    "chart_degress": "Durchschnittstemperaturen",
    "next_desc": "als nächstes erkläre ich dir welche Ursachen die Erwärmung hat.",
    "next_btn": "Start Erklärung Klimawandel"
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
        <div class="columns">
          <div class="column col-12">
            <p>
              {{ $t("intro_1") }}<br/>
              {{ $t("intro_2") }}
            </p>
          </div>

          <div class="column col-12">
            <h6>{{ $t("chart_degress_desc") }}</h6>
          </div>

          <div class="column col-2 flex-centered">
            <img class="img-responsive" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
          <div class="column col-9">
            <vue-c3 :handler="chart"></vue-c3>
          </div>
          <div class="column col-1"/>
        </div>
      </div>
      <div class="modal-footer">
        <div class="columns">
          <div class="column col-1 flex-centered">
            <button @click="navBack" class="btn btn-lg btn float-left"><i class="icon icon-arrow-left"></i></button>
          </div>
          <div class="column col-8 flex-centered">
            {{ $t('next_desc') }}
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
import Vue from 'vue';
import VueC3 from 'vue-c3';
import Colors from '@/utils/colors';

export default {
  components: {
    VueC3,
  },

  data() {
    return {
      chart: new Vue(),
    };
  },

  mounted() {
    this.chart.$emit('init', {
      x: 'year',
      data: {
        url: '/data/european_land_temperature_deviations_annual.csv',
        x: 'year',
        names: {
          'temperature.deviation.degree.celcius': this.$t('chart_degress'),
        },
        type: 'bar',
        colors: {
          'temperature.deviation.degree.celcius': (d) => {
            if (d.value < 0) {
              return Colors.blue;
            }
            return Colors.red;
          },
        },
      },
      bar: {
        width: {
          ratio: 1.2,
        },
      },
      axis: {
        y: {
          max: 2.4,
          min: -0.5,
          label: {
            text: '°C',
            position: 'outer-middle',
          },
        },
      },
    });
  },

  methods: {
    next() {
      this.$router.push({ name: 'B01-GreenhouseEffect1' });
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
