<i18n>
  {
  "de": {
  "title": "Der Treibhauseffekt 🔆 ",
  "next_btn": "weiter"
  }
  }
</i18n>

<template>
  <div class="modal modal-lg modal-bottom" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right"
           aria-label="Close"></a>

        <div class="modal-title h3 flex-centered">
          {{ $t('title') }}
        </div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-12">
            <input @input="renderYear" v-model="year" class="slider" type="range" min="1996" max="2016">
          </div>
          <div class="column col-12 flex-centered">
            <h5>{{ this.year }}</h5>
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
            <button @click="next" class="btn btn-lg btn-success float-right"> {{ $t('next_btn') }}<i
              class="icon icon-arrow-right"></i></button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as d3 from 'd3';
import L from 'leaflet';
import omnivore from 'leaflet-omnivore/leaflet-omnivore';

const countryMappings = {
  Hungary: 'HUN',
  Lithuania: 'LTU',
  Turkey: 'TUR',
  Bulgaria: 'BGR',
  Greece: 'GRC',
  Czechia: 'CZE',
  Austria: 'AUT',
  Ireland: 'IRL',
  Estonia: 'EST',
  Slovakia: 'SVK',
  Romania: 'ROU',
  Belgium: 'BEL',
  Poland: 'POL',
  Norway: 'NOR',
  Sweden: 'SWE',
  Germany: 'DEU',
  Finland: 'FIN',
  'United Kingdom': 'GBR',
  Liechtenstein: 'LIE',
  Croatia: 'HRV',
  Netherlands: 'NLD',
  Slovenia: 'SVN',
  Spain: 'ESP',
  Switzerland: 'CHE',
  Italy: 'ITA',
  France: 'FRA',
  Denmark: 'DNK',
  Malta: 'MLT',
  Luxembourg: 'LUX',
  Iceland: 'ISL',
  Latvia: 'LVA',
  Cyprus: 'CYP',
  Portugal: 'PRT',
};

const layerStyle = {
  weight: 0.5,
  color: 'black',
  opacity: 0.9,
  fillColor: '#000000',
  fillOpacity: 0.1,
};

export default {
  name: 'EntryIntro',

  data() {
    return {
      year: '2016',
      firstRound: true,
      countryLayer: {},
      emissionData: [],
    };
  },

  mounted() {
    this.$parent.removeLayers();
    const that = this;

    // fly map to europe
    this.$parent.map.flyToBounds([
      [50.99995, 9.99995],
      [51.00005, 10.00005],
    ], this.$parent.$options.flyToOptions(3, 1, 1.0));

    this.$parent.map.once('moveend', () => {
      // emissions data load csv
      d3.csv('/data/ghg_emissions.csv').then((rows) => {
        that.emissionData = rows;
        let countriesProcessed = 0;

        // load country shapes
        for (const countryCode of Object.values(countryMappings)) {
          const layerTpl = L.geoJson(null, {
            style() {
              return layerStyle;
            },
          });

          d3.json(`/data/geo_countries/${countryCode}-simplified.json`).then((countryInfo) => {
              const location = countryInfo.View[0].Result[0].Location;
              const layer = omnivore.wkt.parse(location.Shape.Value, null, layerTpl);

              that.countryLayer[countryCode] = layer;
              layer.addTo(that.$parent.$data.mapLayerGroup);
            }).then(() => {
              countriesProcessed = countriesProcessed + 1;
              if (countriesProcessed === Object.keys(countryMappings).length) {
                that.renderYear();
              }

          });
        }
      });
    });
  },

  methods: {
    renderYear() {
      const that = this;

      for (const row of this.emissionData) {
        if (row.year === that.year) {
          const emissionsPerCapita = parseFloat(row['ghg.emissions.per.capita.tonnes']);
          const countryCode = countryMappings[row['country.name']];
          const style = layerStyle;
          style.fillOpacity = 0.5;

          if (emissionsPerCapita <= 5) {
            style.fillColor = '#fcae91';
          } else if (emissionsPerCapita <= 10) {
            style.fillColor = '#fb6a4a';
          } else if (emissionsPerCapita <= 15) {
            style.fillColor = '#de2d26';
          } else {
            style.fillColor = '#a50f15';
          }

          if (that.countryLayer[countryCode]) {
            that.countryLayer[countryCode].setStyle(style);
          }
        }
      }
    },

    modalClose() {
      this.$parent.modalClose();
    },
    next() {
      this.$router.push({ name: 'B02-GreenhouseEffect2' });
    },

    navBack() {
      this.$router.back();
    },
  },
};
</script>

<style scoped>
  .modal-bottom {
    top: unset;
  }
</style>
