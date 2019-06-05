<i18n>
{
  "de": {
    "title": "{year}: Gesamtemissionen und pro Kopf im Vergleich",
    "desc": "Neben den Gesamtemissionen pro Land ist es auch wichtig, auf die Emissionen pro Kopf zu schauen. Hier am Beispiel des Pro-Kopf-Ausstoßes von {year}.",
    "radio_button_total": "Gesamtemissionen",
    "radio_button_capita": "Emissionen pro Kopf",
    "description_total": "Dein Land ist der {countryIndex}-größte Produzent in der EU und für {countryShare}% des EU-weiten Ausstoßes verantwortlich. Weltweit verursacht die EU etwa 10% aller CO2 Emissionen und kommt damit hinter USA und China auf Platz 3 (2017).",
    "description_capita": "Der Durchschnitt in der EU liegt bei {capitaAvg} dein Land liegt bei {capitaShare}. Weltweit liegt der Schnitt bei 4.9 (USA: 15.7 und China: 7.7).",
    "description_footprint": "Teste deinen eigenen Footprint dazu im Vergleich (TODO: Link).",
    "next_btn": "weiter"
  },
  "en": {
    "title": "{year}: Total Emissions and Emissions Per Person in Comparison",
    "desc": "Alongside the total emissions of each country, it's also important to show the emissions per person. Here, for example, are the emissions per person in {year}.",
    "radio_button_total": "Total emissions",
    "radio_button_capita": "Emissions per person",
    "description_total": "Your country is the {countryIndex}-biggest emitter in the EU and is responsible for {countryShare}% of all EU emissions. Globally, the EU produces around 10% of all CO2 emissions, making it the 3rd biggest producer after USA and China (2017).",
    "description_capita": "The average in the EU is {capitaAvg} and your country is at {capitaShare}. The global average is 4.9 (USA: 15.7 and China: 7.7).",
    "description_footprint": "Check your own footprint in comparison: (TODO: Link).",
    "next_btn": "continue"
  }
}
</i18n>

<template>
  <div class="modal modal-lg modal-bottom-center" v-bind:class="{ active: this.$parent.$data.modalOpen }">
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
          <div class="column col-3">
            <label class="form-radio">
              <input v-model="picked" value="total" @change="renderEmissions" type="radio" name="capita-total"><i class="form-icon"></i> {{ $t('radio_button_total') }}
            </label>
            <label class="form-radio">
              <input v-model="picked" value="capita" @change="renderEmissions" type="radio" name="capita-total"><i class="form-icon"></i> {{ $t('radio_button_capita') }}
            </label>
          </div>
          <div class="column col-9">
            <p v-if="picked === 'total'">{{ $t('description_total', {countryShare: this.countryShare, countryIndex: this.countryIndex}) }}</p>
            <p v-if="picked === 'capita'">{{ $t('description_capita', {capitaShare: this.capitaShare, capitaAvg: this.capitaAvg}) }}</p>
          </div>
        </div>
        <div class="column col-12">
          <p>{{ $t('description_footprint') }}</p>
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
      countryIndex: null,
      countryShare: null,
      capitaAvg: null,
      capitaShare: null,
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

    // read countty based stats
    d3.csv('/data/ghg_emissions_ranking-share-2016.csv').then((emissionsRanking) => {
      const homeCountryCode2 = Object.entries(Mappings.countryMapping).filter(m => m[1][1] === this.$parent.$data.homeTownCountryCode)[0][0];

      const emisssionsForHomeCountry = emissionsRanking.filter(r => r['country.code'] === homeCountryCode2)[0];
      const emisssionsForEU28 = emissionsRanking.filter(r => r['country.code'] === 'EU28')[0];
      that.countryIndex = emisssionsForHomeCountry.total_eu28_ghg_tonnes_rank;
      that.countryShare = emisssionsForHomeCountry.total_eu28_ghg_tonnes_share;
      that.capitaAvg = emisssionsForEU28['ghg.emissions.per.capita.tonnes'];
      that.capitaShare = emisssionsForHomeCountry['ghg.emissions.per.capita.tonnes'];

    });

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
