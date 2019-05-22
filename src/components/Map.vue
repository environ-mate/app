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

      L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">'
          + 'OpenStreetMap</a> contributors, &copy; '
          + '<a href="http://cartodb.com/attributions">CartoDB</a>',
      })
        .addTo(this.$parent.map);

      // show centered world view
      this.$parent.map.setView([0, 0], 1);

      // fly to europe
      this.$parent.map.flyToBounds([
        [50.99995, 9.99995],
        [51.00005, 10.00005],
      ],
      this.$parent.$options.flyToOptions(4, 5, 1.0));
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
