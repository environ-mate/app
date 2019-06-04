<i18n>
{
  "de": {
    "title": "Was sind Treibhausgase und woher kommen sie?",
    "desc_1": "Den größten Anteil am Treibhauseffekt hat das Gas CO₂. Der Autoverkehr und die Verbrennung fossiler Brennstoffe (Gas, Erdöl, Kohle) verursachen die meisten CO₂-Emissionen (Ausstoß des Gases in die Umwelt). ",
    "desc_2": "Wenn Treibhausgase einmal freigesetzt sind, bleiben sie unterschiedlich lange in der Atmosphäre - CO₂ zum Beispiel bis zu 120 Jahre.",
    "desc_3": "Daher können wir die Effekte auch mit einem unmittelbaren Stopp der Emissionen nicht sofort umkehren, aber zumindest dafür sorgen, dass sich die Situation nicht verschlimmert.",
    "bullet_desc": "Sie halten unterschiedlich stark die Sonnenwärme zurück auf der Erde: SF₆ z.B. 23.500-fach stärker als CO₂",
    "vis_title": "Treibhausgas-Emissionen {year} in deinem Heimatland {homeTown}",
    "vis_legend_agriculture": "Landwirtschaft",
    "vis_legend_energy": "Energiesektor",
    "vis_legend_waste": "Abfall",
    "vis_legend_transport": "Verkehr",
    "vis_legend_industry": "Industrie",
    "vis_legend_other": "Sonstige",
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
import Colors from '@/utils/colors';

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

  mounted() {
    // emissions data load csv
    d3.csv('/data/ghg_emissions.csv')
      .then((rows) => {
        // map csv country name to home towbn
        const homeCountryName = Object
          .values(Mappings.countryMapping)
          .filter(m => m[1] === this.$parent.$data.homeTownCountryCode)[0][0];

        let data = rows.filter(r => r['country.name'] === homeCountryName && parseInt(r.year, 10) < new Date().getFullYear());

        // take last year found
        data = data.sort((a, b) => a.year - b.year);

        // eslint-disable-next-line
        data = data.slice(-1)[0];
        this.year = data.year;

        data = [
          'agriculture.ghg.emissions.mio.tonnes',
          'energy.ghg.emissions.mio.tonnes',
          'waste.ghg.emissions.mio.tonnes',
          'transport.ghg.emissions.mio.tonnes',
          'industry.ghg.emissions.mio.tonnes',
          'other.ghg.emissions.mio.tonnes',
        ].reduce((result, key) => {
          // eslint-disable-next-line no-param-reassign
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
              'agriculture.ghg.emissions.mio.tonnes': Colors.green,
              'energy.ghg.emissions.mio.tonnes': Colors.orange,
              'waste.ghg.emissions.mio.tonnes': Colors.red,
              'transport.ghg.emissions.mio.tonnes': Colors.blue,
              'industry.ghg.emissions.mio.tonnes': Colors.purple,
              'other.ghg.emissions.mio.tonnes': Colors.yellow,
            },
            type: 'donut',
          },
        });
      });
  },

  methods: {
    next() {
      this.$router.push({ name: 'B05-GreenhouseEffect5' });
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
