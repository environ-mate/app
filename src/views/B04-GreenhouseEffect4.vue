<i18n>
{
  "de": {
    "title": "Was sind Treibhausgase und woher kommen sie?",
    "desc_1": "Den größten Anteil am Treibhauseffekt hat das Gas CO₂. Der Autoverkehr und die Verbrennung fossiler Brennstoffe (Gas, Erdöl, Kohle) verursachen die meisten CO₂-Emissionen (Ausstoß des Gases in die Umwelt).",
    "desc_2": "Wenn Treibhausgase einmal freigesetzt sind, bleiben sie unterschiedlich lange in der Atmosphäre - CO₂ zum Beispiel bis zu 120 Jahre.",
    "desc_3": "Daher können wir die Effekte auch mit einem unmittelbaren Stopp der Emissionen nicht sofort umkehren, aber zumindest dafür sorgen, dass sich die Situation nicht verschlimmert.",
    "bullet_desc": "Sie halten unterschiedlich stark die Sonnenwärme zurück auf der Erde: SF₆ z.B. 23.500-fach stärker als CO₂",
    "vis_title": "Treibhausgas-Emissionen {year} in deinem Heimatland {homeTown}",
    "vis_legend_agriculture": "Landwirtschaft",
    "vis_legend_energy": "Energie",
	"vis_legend_industry": "Industrie",
    "vis_legend_transport": "Verkehr",
    "vis_legend_waste": "Abfall",
    "next_btn": "Weiter"
  },
  "en": {
    "title": "What are greenhouse gases and where do they come from?",
    "desc_1": "The biggest contributor to the greenhouse effect is CO₂ gas. Car traffic and the burning of fossil fuels (gas, oil, coal) causes most of the CO₂ emissions (emissions of the gas into the environment).",
    "desc_2": "Once greenhouse gases are released their stay in the atmosphere varies - CO₂ for example lasts up to 120 years.",
    "desc_3": "Therefore, we cannot immediately reverse the effects with a sudden stop of emissions, but at least make sure that the situation does not get worse.",
    "bullet_desc": "They can hold back the sun's heat on earth with varying degrees of intensity: e.g. SF₆ is 23,500 times stronger than CO₂",
    "vis_title": "Greenhouse gas emissions {year} in your country {homeTown}",
    "vis_legend_agriculture": "agriculture",
    "vis_legend_energy": "energy",
	"vis_legend_industry": "industry",
    "vis_legend_transport": "transport",
	"vis_legend_waste": "waste",
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
        <References v-if="$parent.$data.referencesActive" :references="references" />

        <div v-if="!$parent.$data.referencesActive" class="columns">
          <div class="column col-4 col-sm-10">
            <p>{{ $t('desc_1') }}</p>
            <p>{{ $t('desc_2') }}</p>
            <p>{{ $t('desc_3') }}</p>
          </div>
          <div class="column col-1 col-sm-2">
            <img
              class="img-responsive"
              v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"
            />
          </div>
          <div class="column col-7 col-sm-12">
            <h5>{{ $t('vis_title', {homeTown: this.$parent.$data.homeTownCountryName, year: this.year}) }}</h5>
            <vue-c3 :handler="chart"></vue-c3>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="columns">
          <div class="column col-6 text-left">
            <div class="btn-group">
              <button @click="navBack" class="btn btn-lg btn">
                <i class="icon icon-arrow-left"></i>
              </button>
              <button @click="$parent.toggleReferencesVisibility" class="btn btn-lg">
                <i
                  class="icon"
                  v-bind:class="[$parent.$data.referencesActive ? 'icon-cross' : 'icon-message']"
                ></i>
              </button>
            </div>
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
import * as d3 from 'd3';
import Vue from 'vue';
import VueC3 from 'vue-c3';
import Mappings from '@/utils/mappings';
import Colors from '@/utils/colors';
import References from '@/components/References.vue';

export default {
  components: {
    VueC3,
    References,
  },

  data() {
    return {
      chart: new Vue(),
      year: null,
      references: [
        {
          title: 'Member States greenhouse gas (GHG) emission projections ',
          version: 'TODO',
          link:
            'https://www.eea.europa.eu/data-and-maps/data/greenhouse-gas-emission-projections-for-6',
          publisherName: '',
          publisherLogo: '/assets/data_source_publishers/eea.png',
        },
        {
          title: 'Population and employment',
          version: 'TODO',
          link:
            'https://ec.europa.eu/eurostat/web/products-datasets/-/namq_10_pe',
          publisherName: '',
          publisherLogo: '/assets/data_source_publishers/eurostat.png',
        },
      ],
    };
  },

  mounted() {
    this.renderChart();
  },

  updated() {
    this.renderChart();
  },

  methods: {
    renderChart() {
      // emissions data load csv
      d3.csv('/data/ghg_emissions/ghg_emissions_europe_total_and_per_sector_per_country_most_recent_full_year.csv').then((rows) => {
        // map csv country name to home towbn
        const homeCountryName = Object.values(Mappings.countryMapping).filter(
          m => m[1] === this.$parent.$data.homeTownCountryCode,
        )[0][0];

        let data = rows.filter(
          r => r['country.name'] === homeCountryName
            && parseInt(r.year, 10) < new Date().getFullYear(),
        );

        // take last year found
        data = data.sort((a, b) => a.year - b.year);

        // eslint-disable-next-line
        data = data.slice(-1)[0];
        this.year = data.year;

        data = [
          'agriculture.ghg.emissions.mio.tonnes',
          'energy.ghg.emissions.mio.tonnes',
		  'industry.ghg.emissions.mio.tonnes',
          'transport.ghg.emissions.mio.tonnes',
          'waste.ghg.emissions.mio.tonnes'
        ].reduce((result, key) => {
          // eslint-disable-next-line no-param-reassign
          result[key] = data[key];
          return result;
        }, {});

        this.chart.$emit('init', {
          data: {
            json: data,
            names: {
              'agriculture.ghg.emissions.mio.tonnes': this.$t('vis_legend_agriculture',),
              'energy.ghg.emissions.mio.tonnes': this.$t('vis_legend_energy',),
			  'industry.ghg.emissions.mio.tonnes': this.$t('vis_legend_industry',),
              'transport.ghg.emissions.mio.tonnes': this.$t('vis_legend_transport',),
              'waste.ghg.emissions.mio.tonnes': this.$t('vis_legend_waste')
            },
            colors: {
              'agriculture.ghg.emissions.mio.tonnes': Colors.green,
              'energy.ghg.emissions.mio.tonnes': Colors.orange,
              'industry.ghg.emissions.mio.tonnes': Colors.purple,
			  'transport.ghg.emissions.mio.tonnes': Colors.blue,
              'waste.ghg.emissions.mio.tonnes': Colors.red,
            },
            type: 'donut',
          },
        });
      });
    },

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
