<i18n>
{
  "de": {
    "imprint": "Impressum & Datenschutzerklärung"
  },
   "en": {
    "imprint": "Imprint & Privacy Policy"
  }
}
</i18n>

<template>
  <div id="map"></div>
</template>

<script>
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';

import 'leaflet-easybutton/src/easy-button';
import 'leaflet-easybutton/src/easy-button.css';

export default {
  name: 'Map',

  mounted() {
    this.initMap();
  },

  methods: {
    initMap() {
      L.Icon.Default.imagePath = '.';
      // eslint-disable-next-line
      delete L.Icon.Default.prototype._getIconUrl;

      this.$parent.map = L.map('map');
      const mainLayerGroup = L.layerGroup().addTo(this.$parent.map);
      const imprintRoute = this.$router.resolve('Imprint').href;

      L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', {
        attribution: `${'&copy; <a href="http://www.openstreetmap.org/copyright" target="_blank">'
          + 'OpenStreetMap</a> contributors, &copy; '
          + '<a href="http://arcgisonline.com/attributions" target="_blank">ArcGIS</a> '
          + '| Made With Love, by <b><a href="https://www.feld-m.de/" target="_blank">FELD M</a></b> '
          + '| <a href="'}${imprintRoute}"><b>${this.$t('imprint')}</b></a>`,
      })
        .addTo(mainLayerGroup);

      L.easyButton('<span class="helpButton">H</span>', () => {
        this.$parent.$data.modalOpen = true;
      }).addTo(this.$parent.$data.map);

      // show centered world view
      this.$parent.map.setView([30, -5], 2.5);
    },
  },
};
</script>

<style>
  #map {
    z-index: 0;
    height: 100%;
    width: 100%;
  }

  .leaflet-popup-content {
    font-size: 0.8rem;
    text-align: center;
    font-weight: bold;
  }
</style>
