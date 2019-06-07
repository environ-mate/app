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

      L.Icon.Default.mergeOptions({
        iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
        iconUrl: require('leaflet/dist/images/marker-icon.png'),
        shadowUrl: require('leaflet/dist/images/marker-shadow.png'),
      });

      this.$parent.map = L.map('map');
      const mainLayerGroup = L.layerGroup().addTo(this.$parent.map);

      // https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png
      L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', {
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright" target="_blank">'
          + 'OpenStreetMap</a> contributors, &copy; '
          + '<a href="http://arcgisonline.com/attributions" target="_blank">ArcGIS</a> '
          + '| Made With Love, by <b><a href="https://www.feld-m.de/" target="_blank">FELD M</a></b> ❤️ ',
      })
        .addTo(mainLayerGroup);

      L.easyButton('<span>H</span>', () => {
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
