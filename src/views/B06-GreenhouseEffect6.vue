<i18n>
{
  "de": {
    "title": "Emissionen über die Zeit in Europa",
    "sector_agriculture": "Landwirtschaft",
    "sector_all": "alle Sektoren",
    "sector_energy": "Energiesektor",
    "sector_waste": "Abfall",
    "sector_transport": "Verkehr",
    "sector_industry": "Industrie",
    "sector_agriculture": "Landwirtschaft",
    "sector_other": "Sonstige",
    "description_all": "2017 wurden durch die EU 4168 Gigatonnen (Millionen Tonnen) Treibhausgas-Emissionen produziert. Damit liegt die EU weltweit auf Platz 3, hinter den USA und China. Im Ländervergleich unterscheiden sich die einzelnen Sektoren oft in ihren Anteilen.",
    "description_agriculture": "In der Landwirtschaft wird der größte Anteil an Nicht-CO₂-Gasen erzeugt. NO₂ entsteht bei der Düngung der Felder. CH₄ (Methan) bei der Verdauung in Nutztieren (Kühe, Schweine, Schafe, …) und beim Reisanbau. Dieser Sektor hat einen Gesamtanteil in der EU von 10%.",
    "description_energy": "Bei der Stromerzeugung werden gerade durch die Verbrennung von Braunkohle viele CO₂-Emissionen freigesetzt, aber auch bei der Herstellung von Treibstoff und Benzin entstehen Emissionen. Dies ist mit 28% Anteil in der EU einer der größten Sektoren.",
    "description_waste": "Abfall beinhaltet alles rund um die Müll- und Abwasserverarbeitung (Entsorgung, Kompostierung, Verbrennung, Wasseraufbereitung/-klärung. Auf diesen Sektor entfallen EU-weit 3%.",
    "description_transport": "Verkehr umfasst alle Inlandsflüge sowie Auto-, Bahn- und Lastwagenverkehr. Dieser Sektor hat einen Gesamtanteil in der EU von 21%.",
    "description_industry": "Zum Industrie-Sektor zählen alle Emissionen, die bei der Produktion von Gütern und Rohmaterialien entstehen. Dieser Sektor hat einen Gesamtanteil von 9%.",
    "description_other": "Hierin sind verschiedene weitere Sektoren zusammengefasst, der Größte hiervon macht über 50% aus und umfasst die Emissionen von Gebäuden (Heizung, Abwasser, Strom in Wohnungen oder Geschäften). Der gesamte Sektor hat einen Gesamtanteil von 28% an allen EU-Emissionen.",
    "next_desc": "Zu den Auswirkungen erzähle ich dir jetzt mehr.",
    "next_btn": "weiter"
  },
  "en": {
    "title": "Emissions Over Time in Europe",
    "sector_agriculture": "Agriculture",
    "sector_all": "All Sectors",
    "sector_energy": "Energy",
    "sector_waste": "Waste",
    "sector_transport": "Transport",
    "sector_industry": "Industry",
    "sector_agriculture": "Agriculture",
    "sector_other": "Other",
    "description_all": "In 2017 the EU produced 4168 Gigatons (Million tons) of greenhouse gases. This makes the EU the 3rd biggest global greenhouse gas emitter, after the USA and China. However, individual EU nations differ both in how much each sector contributes, and their overall contribution to total EU emissions. This sector is responsible for 21% of the total emissions in the EU.",
    "description_agriculture": "In agriculture most emissions come from non-CO₂ gases. NO₂ is produced by the fertilisation of fields. CH₄ (methane) is produced by the digestive systems of livestock (cows, pigs, sheep, etc.) and by rice fields. This sector is responsible for 10% of the total emissions in the EU.",
    "description_energy": "",
    "description_waste": "Waste includes everything around waste and waste water processing (disposal, composting, incineration and water treatment). This sector is responsible for 3% of the EU total emissions.",
    "description_transport": "",
    "description_industry": "",
    "description_other": "",
    "next_desc": "Now, I'll explain some of the consequences to you.",
    "next_btn": "continue"
  }
}
</i18n>

<template>
  <div class="modal modal modal-bottom-right" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right"
           aria-label="Close"></a>

        <div class="modal-title h4 flex-centered">
          {{ $t('title') }} 🔆
        </div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-11">
            <input @input="renderYear" v-model="year" class="slider" type="range" min="1990" max="2016">
          </div>
          <div class="column col-1"><h5>{{ this.year }}</h5></div>

          <div class="column col-3">
            <select v-model="sectorSelected" @change="renderYear()" class="form-select">
              <option v-for="(name, sectorID) in sectors" v-bind:value="sectorID" v-bind:key="sectorID">{{ name }}</option>
            </select>
          </div>
          <div class="column col-8">
            <div v-if="sectorSelected === 'total'">{{ $t('description_all') }}</div>
            <div v-if="sectorSelected === 'agriculture'">{{ $t('description_agriculture') }}</div>
            <div v-if="sectorSelected === 'waste'">{{ $t('description_waste') }}</div>
            <div v-if="sectorSelected === 'energy'">{{ $t('description_energy') }}</div>
            <div v-if="sectorSelected === 'industry'">{{ $t('description_industry') }}</div>
            <div v-if="sectorSelected === 'transport'">{{ $t('description_transport') }}</div>
            <div v-if="sectorSelected === 'other'">{{ $t('description_other') }}</div>
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
      sectorSelected: 'total',
      defaultSector: 'total',
      sectors: {
        total: this.$t('sector_all'),
        energy: this.$t('sector_energy'),
        waste: this.$t('sector_waste'),
        transport: this.$t('sector_transport'),
        industry: this.$t('sector_industry'),
        agriculture: this.$t('sector_agriculture'),
        other: this.$t('sector_other'),
      },
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
            that.renderYear();
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
    renderYear() {
      const that = this;

      // filter by sector
      this.valueColumn = `${this.sectorSelected}.ghg.emissions.mio.tonnes`;

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
      this.$router.push({ name: 'C01-ClimateChangeEffectsIntro' });
    },

    navBack() {
      this.$router.back();
    },
  },
};
</script>
