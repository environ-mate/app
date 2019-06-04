<i18n>
{
  "de": {
    "title": "{year}: Gesamtemissionen und pro Kopf im Vergleich",
    "desc": "Neben den Gesamtemissionen pro Land ist es auch wichtig, auf die Emissionen pro Kopf zu schauen. Hier am Beispiel des Pro-Kopf-Ausstoßes von {year}.",
    "radio_button_total": "Gesamtemissionen",
    "radio_button_capita": "Emissionen pro Kopf",
    "description_gesamt": "",
    "description_per_capita": "",
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

        <div class="modal-title h4 flex-centered">
          {{ $t('title', {year: this.year}) }}
        </div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-12">
            <p>
              {{ $t('desc', {year: this.year}) }}
            </p>
          </div>
          <div class="column col-5">
            <label class="form-radio">
              <input v-model="picked" value="total" @change="renderEmissions" type="radio" name="capita-total"><i class="form-icon"></i> {{ $t('radio_button_total') }}
            </label>
            <label class="form-radio">
              <input v-model="picked" value="capita" @change="renderEmissions" type="radio" name="capita-total"><i class="form-icon"></i> {{ $t('radio_button_capita') }}
            </label>
          </div>
          <div class="column col-">
            TODO: GESAMT | KOPF
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
import Mappings from '@/utils/mappings';

const colors = ['#fcae91', '#fb6a4a', '#de2d26', '#a50f15'];

const layerStyle = {
  weight: 0.5,
  color: 'black',
  opacity: 0.9,
  fillColor: '#000000',
  fillOpacity: 0.1,
};

export default {
  data() {
    return {
      year: '2016',
      countryLayer: {},
      emissionData: [],
      picked: 'capita',
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
        that.emissionData = this.emissionData.filter(r => r['country.name'] !== 'EU28');

        let countriesProcessed = 0;

        function renderInitial() {
          countriesProcessed += 1;
          if (countriesProcessed === Object.keys(Mappings.countryMapping).length) {
            that.renderEmissions();
          }
        }

        // load country shapes
        for (const countryMapping of Object.values(Mappings.countryMapping)) {
          const countryCode = countryMapping[1];

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
          }).then(renderInitial);
        }
      });
    });
  },

  methods: {
    renderEmissions() {
      const that = this;

      if (this.picked === 'capita') {
        this.valueColumn = 'ghg.emissions.per.capita.tonnes';
      } else {
        this.valueColumn = 'total.ghg.emissions.mio.tonnes';
      }

      const valueMin = Math.min(...this.emissionData.map(r => r[this.valueColumn]));
      const valueMax = Math.max(...this.emissionData.map(r => r[this.valueColumn]));
      const valueRange = valueMax - valueMin;
      const valueRangeDistributed = valueRange / colors.length;

      const rowsOfInterest = this.emissionData.filter(r => r.year === that.year);

      for (const row of rowsOfInterest) {
        if (row.year === that.year) {
          const value = parseFloat(row[this.valueColumn]);
          const countryCode = Object
            .values(Mappings.countryMapping)
            .filter(m => m[0] === row['country.name'])[0][1];

          const style = layerStyle;
          style.fillOpacity = 0.5;

          let colorIndex = Math.ceil(((value - valueMin) / valueRangeDistributed) - 1);
          if (colorIndex < 0) {
            colorIndex = 0;
          }
          if (colorIndex > colors.length - 1) {
            colorIndex = colors.length - 1;
          }

          style.fillColor = colors[colorIndex];

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
      this.$router.push({ name: 'B06-GreenhouseEffect6' });
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
