<i18n>
{
  "de": {
    "title": "Was sind Treibhausgase und woher kommen sie?",
    "desc_1": "Den größten Anteil hat CO2 und im Energiesektor entstehen die meisten Emissionen (Ausstoß an Gasen in die Umwelt). ",
    "desc_2": "Treibhausgase bleiben einmal freigesetzt unterschiedlich lange in der Atmosphäre. CO2 verbleibt bis zu 120 Jahre. ",
    "desc_3": "Somit können wir die Effekte auch mit einem sofortigen Stopp nicht sofort umkehren aber zumindest dafür sorgen, dass sich die Auswirkungen nicht weiter verstärken. ",
    "bullet_desc": "Sie halten unterschiedlich stark die Sonnenwärme zurück auf der Erde: SF6 z.B. 23.500-fach stärker als CO2",
    "vis_title": "Treibhausgas Emissionen 2018 in deinem Heimatland {homeTown}",
    "next_desc": "Zu den Auswirkungen erzähle ich Dir jetzt mehr.",
    "next_btn": "weiter"
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
          <div class="column col-1">
            <img class="img-responsive" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
          <div class="column col-4">
            <p>{{ $t('desc_1') }}</p>
            <p>{{ $t('desc_2') }}</p>
            <p>{{ $t('desc_3') }}</p>
          </div>
          <div class="column col-7">
            <h5>{{ $t('vis_title', {homeTown: this.$parent.$data.homeTownCountryName}) }}</h5>
            <vue-c3 :handler="chart"></vue-c3>
          </div>
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
import * as d3 from 'd3';
import Vue from 'vue';
import VueC3 from 'vue-c3';

export default {
  components: {
    VueC3,
  },

  data() {
    return {
      chart: new Vue(),
      year: '2018',
    };
  },

  mounted() {
    // emissions data load csv
    d3.csv('/data/ghg_emissions.csv').then((rows) => {
      let data = rows.filter(r => r.year === this.year && r['country.name'] === 'Germany')[0];
      data = [
        'agriculture.ghg.emissions.mio.tonnes',
        'energy.ghg.emissions.mio.tonnes',
        'waste.ghg.emissions.mio.tonnes',
        'transport.ghg.emissions.mio.tonnes',
        'industry.ghg.emissions.mio.tonnes',
      ].reduce((result, key) => { result[key] = data[key]; return result; }, {});

      console.log(data);

      this.chart.$emit('init', {
        data: {
          json: data,
          names: {
            'agriculture.ghg.emissions.mio.tonnes': 'Landwirtschaft',
            'energy.ghg.emissions.mio.tonnes': 'Energiesektor',
            'waste.ghg.emissions.mio.tonnes': 'Abfall',
            'transport.ghg.emissions.mio.tonnes': 'Verkehr',
            'industry.ghg.emissions.mio.tonnes': 'Industrie',
          },
          type: 'donut',
        },
      });
    });
  },

  methods: {
    next() {
      this.$router.push({ name: 'Z00-WIP' });
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
