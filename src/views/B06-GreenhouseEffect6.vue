<i18n>
{
  "de": {
    "title": "Emissionen über die Zeit in Europa",
    "sector_total": "Alle Sektoren",
	"sector_agriculture": "Landwirtschaft",
    "sector_energy": "Energie",
    "sector_industry": "Industrie",
    "sector_transport": "Verkehr",
    "sector_waste": "Abfall",
    "description_all_sectors": "2019 wurden durch die EU 4.160 Millionen Tonnen Treibhausgas-Emissionen produziert. Damit liegt die EU weltweit auf Platz 3 - hinter den USA und China. Im Ländervergleich unterscheiden sich die einzelnen Sektoren oft in ihren Anteilen.",
    "description_agriculture": "In der Landwirtschaft wird der größte Anteil an Nicht-CO₂-Gasen erzeugt. NO₂ entsteht bei der Düngung der Felder. CH₄ (Methan) bei der Verdauung in Nutztieren (z.B. Kühe, Schweine, Schafe ) und beim Reisanbau. Dieser Sektor hat einen Gesamtanteil in der EU von 10%.",
    "description_energy": "Bei der Stromerzeugung werden gerade durch die Verbrennung von Braunkohle viele CO₂-Emissionen freigesetzt, aber auch bei der Herstellung von Treibstoff und Benzin entstehen Emissionen. Dies ist mit 55% Anteil in der EU einer der größten Sektoren.",
    "description_industry": "Zum Industrie-Sektor zählen alle Emissionen, die bei der Produktion von Gütern und Rohmaterialien entstehen. Dieser Sektor hat einen Gesamtanteil von 9%.",
    "description_transport": "Verkehr umfasst alle Inlandsflüge sowie Auto-, Bahn- und Lastwagenverkehr. Dieser Sektor hat einen Gesamtanteil in der EU von 23%.",
    "description_waste": "Abfall beinhaltet alles rund um die Müll- und Abwasserverarbeitung (e.g. Entsorgung, Kompostierung, Verbrennung, Wasseraufbereitung/-klärung). Auf diesen Sektor entfallen EU-weit 3%.",
    "million_tons": "Mio. Tonnen",
    "next_desc": "Zu den Auswirkungen erzähle ich dir jetzt mehr.",
    "next_btn": "Weiter"
  },
  "en": {
    "title": "Emissions Over Time in Europe",
    "sector_total": "All sectors",
	"sector_agriculture": "Agriculture",
    "sector_energy": "Energy",
	"sector_industry": "Industry",
    "sector_transport": "Transport",
    "sector_waste": "Waste",
    "description_all_sectors": "In 2019 the EU produced 4,160 million tons of greenhouse gases. This makes the EU the 3rd biggest global greenhouse gas emitter - after the USA and China. However, individual EU nations differ both in how much each sector contributes, and their overall contribution to total EU emissions.",
    "description_agriculture": "In agriculture most emissions come from non-CO₂ gases. NO₂ is produced by the fertilisation of fields. CH₄ (methane) is produced by the digestive systems of livestock (e.g. cows, pigs, sheep) and by rice fields. This sector is responsible for 10% of the total emissions in the EU.",
    "description_energy": "When it comes to energy generation, the burning of brown coal in particular contributes heavily to CO₂ emissions - the use of fuels such as petrol doesn't help either. This is one of the biggest sectors in terms of emissions, contributing 55% of the EU's total CO₂ output.",
    "description_industry": "The industry sector covers emissions resulting from the production of goods and raw materials. This sector is responsible for 9% of total EU emissions.",
    "description_transport": "Transport covers all inland traffic by car, train and truck. This sector is responsible for 23% of all EU emissions.",
    "description_waste": "Waste includes everything around waste and waste water processing (e.g. disposal, composting, incineration and water treatment). This sector is responsible for 3% of the EU total emissions.",
    "million_tons": "mio. tonnes",
    "next_desc": "Now, we will have a look at the consequences.",
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

        <div class="modal-title h4">{{ $t('title') }} 🔆</div>
      </div>
      <div class="modal-body">
        <References v-if="$parent.$data.referencesActive" :references="references" />

        <div v-else>
          <div class="d-flex mb-2">
            <div class="flex-1 mr-2">
              <input
                @input="renderYear"
                v-model="year"
                class="slider"
                type="range"
                min="1990"
                max="2040"
              />
            </div>
            <h5>{{ this.year }}</h5>
          </div>

          <div class="mb-2">
            <select v-model="sectorSelected" @change="renderYear()" class="form-select">
              <option
                v-for="(name, sectorID) in sectors"
                v-bind:value="sectorID"
                v-bind:key="sectorID"
              >{{ name }}</option>
            </select>
          </div>
          <div class="mb-3">
            <div v-if="sectorSelected === 'total'">{{ $t('description_all_sectors') }}</div>
            <div v-if="sectorSelected === 'agriculture'">{{ $t('description_agriculture') }}</div>
            <div v-if="sectorSelected === 'energy'">{{ $t('description_energy') }}</div>
            <div v-if="sectorSelected === 'industry'">{{ $t('description_industry') }}</div>
            <div v-if="sectorSelected === 'transport'">{{ $t('description_transport') }}</div>
			<div v-if="sectorSelected === 'waste'">{{ $t('description_waste') }}</div>
          </div>
          <div class="text-right">{{ $t('next_desc') }}</div>
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
      sectorSelected: 'total',
      defaultSector: 'total',
      sectors: {
        total: this.$t('sector_total'),
		agriculture: this.$t('sector_agriculture'),
        energy: this.$t('sector_energy'),
		industry: this.$t('sector_industry'),
        transport: this.$t('sector_transport'),
        waste: this.$t('sector_waste')
      },
      references: [
        {
          title: 'National emissions reported to the UNFCCC and to the EU Greenhouse Gas Monitoring Mechanism',
          version: 'TODO',
          link:
            'https://www.eea.europa.eu/data-and-maps/data/national-emissions-reported-to-the-unfccc-and-to-the-eu-greenhouse-gas-monitoring-mechanism-15',
          publisherName: '',
          publisherLogo: '/assets/data_source_publishers/eea.png',
        },
        {
          title: 'Member States greenhouse gas (GHG) emission projections',
          version: 'TODO',
          link:
            'https://www.eea.europa.eu/data-and-maps/data/greenhouse-gas-emission-projections-for-6',
          publisherName: '',
          publisherLogo: '/assets/data_source_publishers/eea.png',
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

    this.$parent.map.once('moveend', () => {
      // emissions data load csv
      d3.csv('/data/ghg_emissions/ghg_emissions_europe_total_and_per_sector_per_country.csv').then((rows) => {
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
          that.renderYear();
        });
      });
    });
  },

  methods: {
    renderYear() {
      const that = this;

      // filter by sector
      this.valueColumn = `${this.sectorSelected}.ghg.emissions.mio.tonnes`;
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
      this.$router.push({ name: 'C01-ClimateChangeEffectsIntro' });
    },

    navBack() {
      this.$router.back();
    },
  },
};
</script>
