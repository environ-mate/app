<template>
  <div id="map"></div>
</template>

<script>
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import 'spectre.css';
import 'spectre.css/dist/spectre-exp.css';
import 'spectre.css/dist/spectre-icons.css';
import 'vue-i18n/dist/vue-i18n';

export default {
  name: 'Map',

  mounted() {
    this.initMap();
  },

  methods: {
    initMap() {
      this.$parent.map = L.map('map');

      // https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png
      L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', {
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">'
          + 'OpenStreetMap</a> contributors, &copy; '
          + '<a href="http://arcgisonline.com/attributions">ArcGIS</a>',
      })
        .addTo(this.$parent.map);

      // show centered world view
      this.$parent.map.setView([0, 0], 0);
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
</style>
