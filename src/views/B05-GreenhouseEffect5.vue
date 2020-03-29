<i18n>
{
  "de": {
    "title": "{year}: Gesamtemissionen und Emissionen pro Kopf im Vergleich",
    "desc": "Neben den Gesamtemissionen pro Land ist es auch wichtig, auf die Emissionen pro Kopf zu schauen. Hier am Beispiel des Pro-Kopf-Ausstoßes von {year}.",
    "radio_button_total": "Gesamtemissionen",
    "radio_button_capita": "Emissionen pro Kopf",
    "description_total": "Dein Land ist der {countryIndex}-größte Produzent in der EU und für {countryShare}% des EU-weiten Ausstoßes verantwortlich. Weltweit verursacht die EU etwa 11% aller CO₂-Emissionen und kommt damit auf Platz 3, hinter den USA und China (Stand: 2019).",
    "description_capita": "Der Durchschnitt in der EU liegt bei {capitaAvg} Tonnen pro Kopf. Dein Land liegt bei {capitaShare} Tonnen pro Kopf. Weltweit liegt der Schnitt bezogen auf CO₂-Emissionen bei 4.9 Tonnen pro Kopf (USA 20.1 und China 9.4 Tonnen pro Kopf).",
    "description_footprint": "<a href='https://www.footprintcalculator.org/' target='_blank'>Teste deinen eigenen Footprint dazu im Vergleich (www.footprintcalculator.org)</a>",
    "million_tons": "Mio. Tonnen",
    "next_btn": "Weiter"
  },
  "en": {
    "title": "{year}: Total Emissions and Emissions Per Capita in Comparison",
    "desc": "Alongside the total emissions of each country, it's also important to show the emissions per person. Here, for example, are the emissions per person in {year}.",
    "radio_button_total": "Total emissions",
    "radio_button_capita": "Emissions per capita",
    "description_total": "Your country is the {countryIndex}-biggest emitter in the EU and is responsible for {countryShare}% of all EU emissions. Globally, the EU produces around 11% of all CO₂ emissions, making it the 3rd biggest producer after USA and China (2019).",
    "description_capita": "The average in the EU is {capitaAvg} tonnes per capita and your country is at {capitaShare} tonnes per capita. The global average is 4.9 tonnes per capita (USA 20.1 and China 9.1 tonnes per capita, respectively).",
    "description_footprint": "<a href='https://www.footprintcalculator.org/' target='_blank'>Check your own footprint in comparison (www.footprintcalculator.org)</a>",
    "million_tons": "mio. tonnes",
    "next_btn": "Continue"
  }
}
</i18n>

<template>
  <div
    class="modal modal modal-bottom-right"
    v-bind:class="{ active: this.$parent.$data.modalOpen }"
  >
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right" aria-label="Close"></a>

        <div class="modal-title h3">{{ $t('title', {year: this.year}) }}</div>
      </div>
      <div class="modal-body">
        <References v-if="$parent.$data.referencesActive" :references="references" />

        <div v-if="!$parent.$data.referencesActive" class="columns">
          <div class="column col-12">
            <p>{{ $t('desc', {year: this.year}) }}</p>
          </div>
          <div class="column col-5 col-sm-12">
            <div class="columns">
              <div class="column col-12 col-sm-6 col-xs-12">
                <label class="form-radio">
                  <input
                    v-model="picked"
                    value="total"
                    @change="renderEmissions"
                    type="radio"
                    name="capita-total"
                  />
                  <i class="form-icon"></i>
                  {{ $t('radio_button_total') }}
                </label>
              </div>
              <div class="column col-12 col-sm-6 col-xs-12">
                <label class="form-radio">
                  <input
                    v-model="picked"
                    value="capita"
                    @change="renderEmissions"
                    type="radio"
                    name="capita-total"
                  />
                  <i class="form-icon"></i>
                  {{ $t('radio_button_capita') }}
                </label>
              </div>
            </div>
          </div>
          <div class="column col-7 col-sm-12">
            <p
              v-if="picked === 'total'"
            >{{ $t('description_total', {countryShare: this.countryShare, countryIndex: this.countryIndex}) }}</p>
            <p
              v-if="picked === 'capita'"
            >{{ $t('description_capita', {capitaShare: this.capitaShare, capitaAvg: this.capitaAvg}) }}</p>
          </div>

          <div class="column col-12"></div>
          <div class="column col-12">
            <p v-html="$t('description_footprint')"></p>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="columns">
          <div class="column col-6 text-left">
            <div class="btn-group">
              <button @click="navBack" class="btn btn-lg">
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
import L from 'leaflet';
import omnivore from 'leaflet-omnivore/leaflet-omnivore';
import Mappings from '@/utils/mappings';
import Colors from '@/utils/colors';
import References from '@/components/References.vue';

const layerStyle = {
  weight: 0.5,
  color: 'black',
  opacity: 0.9,
  fillColor: '#000000',
  fillOpacity: 0.1,
};

export default {
  components: {
    References,
  },

  data() {
    return {
      year: '2019',
      countryLayer: {},
      emissionData: [],
      picked: 'capita',
      countryIndex: null,
      countryShare: null,
      capitaAvg: null,
      capitaShare: null,
      references: [
        {
          title: 'Member States greenhouse gas (GHG) emission projections',
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
    this.$parent.removeLayers();
    const that = this;

    // fly map to europe
    this.$parent.map.flyToBounds(
      [[50.99995, 9.99995], [51.00005, 10.00005]],
      this.$parent.$options.flyToOptions(3, 1, 1.0),
    );

    // read county based stats
    d3.csv('/data/ghg_emissions/ghg_emissions_total_per_capita_EU_share_EU_rank.csv').then(
      (emissionsRanking) => {
        const homeCountryCode2 = Object.entries(Mappings.countryMapping).filter(
          m => m[1][1] === this.$parent.$data.homeTownCountryCode,
        )[0][0];

        const emisssionsForHomeCountry = emissionsRanking.filter(
          r => r['country.code'] === homeCountryCode2,
        )[0];
        const emisssionsForEU = emissionsRanking.filter(
          r => r['country.code'] === 'EU',
        )[0];
        that.countryIndex = emisssionsForHomeCountry["total.ghg.emissions.EU.rank"];
        that.countryShare = emisssionsForHomeCountry["total.ghg.emissions.EU.share"];
        that.capitaAvg = emisssionsForEU['ghg.emissions.per.capita.tonnes'];
        that.capitaShare = emisssionsForHomeCountry['ghg.emissions.per.capita.tonnes'];
      },
    );

    this.$parent.map.once('moveend', () => {
      // emissions data load csv
      d3.csv('/data/ghg_emissions/ghg_emissions_europe_total_and_per_sector_per_country_most_recent_full_year.csv').then((rows) => {
        that.emissionData = rows;
        that.emissionData = this.emissionData.filter(
          r => r['country.name'] !== 'EU',
        );

        // load country shapes
        const promises = [];

        for (const countryMapping of Object.values(Mappings.countryMapping)) {
          const countryCode = countryMapping[1];

          const layerTpl = L.geoJson(null, {
            style() {
              return layerStyle;
            },
          });

          const promise = d3
            .json(`/data/geo_countries/${countryCode}-simplified.json`)
            .then((countryInfo) => {
              const location = countryInfo.View[0].Result[0].Location;
              const layer = omnivore.wkt.parse(
                location.Shape.Value,
                null,
                layerTpl,
              );

              that.countryLayer[countryCode] = layer;
              layer.addTo(that.$parent.$data.mapLayerGroup);
            });

          promises.push(promise);
        }

        Promise.all(promises).then(() => {
          that.renderEmissions();
        });
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

      const rowsOfInterest = this.emissionData.filter(
        r => r.year === that.year,
      );

      const valueMin = Math.min(
        ...rowsOfInterest.map(r => r[this.valueColumn]),
      );
      const valueMax = Math.max(
        ...rowsOfInterest.map(r => r[this.valueColumn]),
      );
      const valueRange = valueMax - valueMin;
      const valueRangeDistributed = valueRange / Colors.redScale.length;

      // unset existing tooltips
      this.$parent.$data.map.eachLayer((layer) => {
        if (layer.options.pane === 'tooltipPane') {
          layer.removeFrom(that.$parent.$data.map);
        }
      });

      for (const row of rowsOfInterest) {
        if (row.year === that.year) {
          const value = parseFloat(row[this.valueColumn]);
          const countryCode = Object.values(Mappings.countryMapping).filter(
            m => m[0] === row['country.name'],
          )[0][1];

          const style = layerStyle;
          style.fillOpacity = 0.5;

          let colorIndex = Math.ceil(
            (value - valueMin) / valueRangeDistributed - 1,
          );
          if (colorIndex < 0) {
            colorIndex = 0;
          }
          if (colorIndex > Colors.redScale.length - 1) {
            colorIndex = Colors.redScale.length - 1;
          }

          style.fillColor = Colors.redScale[colorIndex];

          if (that.countryLayer[countryCode]) {
            that.countryLayer[countryCode].setStyle(style);

            // open tooltip on mouse over
            const unit = that.$i18n.t('million_tons');
            that.countryLayer[countryCode].bindTooltip(`${value} ${unit} `, {
              sticky: true,
            });
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
