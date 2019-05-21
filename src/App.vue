<template>
  <div id="app">
    <div id="map"/>
    <router-view/>
  </div>
</template>

<script>
import L from 'leaflet';
import 'leaflet-fullscreen/dist/Leaflet.fullscreen';
import 'leaflet-fullscreen/dist/leaflet.fullscreen.css';
import 'leaflet/dist/leaflet.css';
import 'spectre.css';
import 'spectre.css/dist/spectre-exp.css';
import 'spectre.css/dist/spectre-icons.css';

export default {
  name: 'App',

  flyToOptions(maxZoom, duration, easeLinearity) {
    return {
      maxZoom,
      duration: duration || 3.0,
      easeLinearity: easeLinearity || 0.2,
    };
  },

  data() {
    return {
      map: null,
    };
  },

  mounted() {
    this.initMap();
  },

  destroyed() {
  },

  methods: {
    initMap() {
      this.map = L.map('map', {
        fullscreenControl: {
          pseudoFullscreen: false,
        },
      });

      L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">'
          + 'OpenStreetMap</a> contributors, &copy; '
          + '<a href="http://cartodb.com/attributions">CartoDB</a>',
      })
        .addTo(this.map);

      // show centered world view
      this.map.setView([0, 0], 1);

      // fly to europe
      this.map.flyToBounds([
        [50.99995, 9.99995],
        [51.00005, 10.00005],
      ],
      this.$options.flyToOptions(4, 5, 1.0));

      this.map.once('moveend', () => this.$router.push({ name: 'EntryIntro' }));
    },
  },
};
</script>

<style>
  body {
    padding: 0;
    margin: 0;
  }

  html, body, #app {
    height: 100%;
    width: 100%;
  }

  #map {
    z-index: 0;
    height: 100%;
    width: 100%;
  }

  .modal-body, .modal-container {
    height: max-content;
  }

  .hide {
    display:none;
  }
</style>
