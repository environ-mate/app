<i18n>
{
  "de": {
    "title": "Was sind Treibhausgase und woher kommen sie?",
    "desc_1": "Den größten Anteil hat CO2 und im Energiesektor entstehen die meisten Emissionen (Ausstoß an Gasen in die Umwelt). ",
    "desc_2": "Treibhausgase bleiben einmal freigesetzt unterschiedlich lange in der Atmosphäre. CO2 verbleibt bis zu 120 Jahre. ",
    "desc_3": "Somit können wir die Effekte auch mit einem sofortigen Stopp nicht sofort umkehren aber zumindest dafür sorgen, dass sich die Auswirkungen nicht weiter verstärken. ",
    "bullet_desc": "Sie halten unterschiedlich stark die Sonnenwärme zurück auf der Erde: SF6 z.B. 23.500-fach stärker als CO2",
    "vis_title": "Treibhausgas Emissionen {year} in deinem Heimatland {homeTown}",
    "vis_legend_agriculture": "Landxwirtschaft",
    "vis_legend_energy": "Energiesektor",
    "vis_legend_waste": "Abfall",
    "vis_legend_transport": "Verkehr",
    "vis_legend_industry": "Industrie",
    "vis_legend_other": "Sonstige",
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
          <div class="column col-4">
            <p>{{ $t('desc_1') }}</p>
            <p>{{ $t('desc_2') }}</p>
            <p>{{ $t('desc_3') }}</p>
          </div>
          <div class="column col-1 flex">
            <img class="img-responsive flex-end" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
          <div class="column col-7">
            <h5>{{ $t('vis_title', {homeTown: this.$parent.$data.homeTownCountryName, year: this.year}) }}</h5>
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
import Mappings from '@/utils/mappings';

export default {
  components: {
    VueC3,
  },

  data() {
    return {
      chart: new Vue(),
      year: null,
    };
  },

  mounted: function () {
    // emissions data load csv
    d3.csv('/data/ghg_emissions.csv')
      .then((rows) => {
        // map csv country name to home towbn
        const homeCountryName = Object
          .values(Mappings.countryMapping)
          .filter(m => m[1] === this.$parent.$data.homeTownCountryCode)[0][0];

        let data = rows.filter(r => r['country.name'] === homeCountryName && parseInt(r['year']) < new Date().getFullYear());

        // take last year found
        data = data.sort(function (a, b) {
          return a.year - b.year;
        });
        data = data.slice(-1)[0];

        this.year = data.year;

        data = [
          'agriculture.ghg.emissions.mio.tonnes',
          'energy.ghg.emissions.mio.tonnes',
          'waste.ghg.emissions.mio.tonnes',
          'transport.ghg.emissions.mio.tonnes',
          'industry.ghg.emissions.mio.tonnes',
        ].reduce((result, key) => {
          result[key] = data[key];
          return result;
        }, {});

        this.chart.$emit('init', {
          data: {
            json: data,
            names: {
              'agriculture.ghg.emissions.mio.tonnes': this.$t('vis_legend_agriculture'),
              'energy.ghg.emissions.mio.tonnes': this.$t('vis_legend_energy'),
              'waste.ghg.emissions.mio.tonnes': this.$t('vis_legend_waste'),
              'transport.ghg.emissions.mio.tonnes': this.$t('vis_legend_transport'),
              'industry.ghg.emissions.mio.tonnes': this.$t('vis_legend_industry'),
              'other.ghg.emissions.mio.tonnes': this.$t('vis_legend_other'),
            },
            colors: {
              'agriculture.ghg.emissions.mio.tonnes': '#74c476',
              'energy.ghg.emissions.mio.tonnes': '#fc8d59',
              'waste.ghg.emissions.mio.tonnes': '#fb6a4a',
              'transport.ghg.emissions.mio.tonnes': '#67a9cf',
              'industry.ghg.emissions.mio.tonnes': '#9e9ac8',
              'other.ghg.emissions.mio.tonnes': '#ffffb2',
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
