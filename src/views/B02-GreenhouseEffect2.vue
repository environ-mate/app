<i18n>
{
  "de": {
    "title": "Der Treibhauseffekt   🔆",
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

        <div class="modal-title h3 flex-centered">
           {{ $t("title") }}
        </div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-12">

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
            <button @click="navBack" class="btn btn-lg btn-success float-right"> {{ $t('next_btn') }}<i class="icon icon-arrow-right"></i></button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import L from 'leaflet';
import * as d3 from 'd3';
import omnivore from 'leaflet-omnivore/leaflet-omnivore';

export default {
  name: 'EntryIntro',

  mounted() {
    this.$parent.removeLayers();

    const mapping = {
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

    d3.csv('/data/ghg_emissions.csv').then((rows) => {
      for (let row of rows) {
        if (row.year === '1996') {
          const emissionsPerCapita = parseFloat(row['total.ghg.emissions.mio.tonnes']);
          let color;
          if (emissionsPerCapita <= 5) {
            color = '#fcae91';
          } else if (emissionsPerCapita <= 10) {
            color = '#fb6a4a';
          } else if (emissionsPerCapita <= 15) {
            color = '#de2d26';
          } else {
            color = '#a50f15';
          }

          const layerTpl = L.geoJson(null, {
            style() {
              return {
                weight: 0.5,
                color: 'black',
                opacity: 0.9,
                fillColor: color,
                fillOpacity: 0.5,
              };
            },
          });

          const countryCode = mapping[row['country.name']];
          d3.json(`/data/geo_countries/${countryCode}.json`).then((countryInfo) => {
            const location = countryInfo.View[0].Result[0].Location;
            const layer = omnivore.wkt.parse(location.Shape.Value, {precision: 5}, layerTpl);
            layer.addTo(this.$parent.$data.mapLayerGroup);
            console.log(countryCode, emissionsPerCapita);
          });
        }
      }
    });
  },

  methods: {
    next() {
      this.$router.push({ name: 'A03-EntryHomeTownSelect' });
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
