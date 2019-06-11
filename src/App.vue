<template>
  <div id="app">
    <Map/>
    <router-view/>
  </div>
</template>

<script>
import Map from '@/components/Map.vue';
import L from 'leaflet';
import '@/vendors/spectre.css/spectre.css';
import '@/vendors/spectre.css/spectre-icons.css';
import '@/vendors/spectre.css/spectre-exp.css';
import 'vue-i18n/dist/vue-i18n';
import 'c3/c3.css';
import '@/vendors/leaflet-svgicon/svg-icon';

export default {
  name: 'App',

  data() {
    return {
      map: null,
      mapLayerGroup: L.layerGroup(),
      homeTownName: null,
      homeTownCoords: null,
      homeTownCountryName: null,
      homeTownCountryCode: null,
      tutor: null,
      modalOpen: false,
      referencesActive: false,
    };
  },

  mounted() {
    if (this.tutor === null) {
      this.removeLayers();

      if (this.$route.name !== 'Imprint') {
        this.$router.push({ name: 'A01-EntryLanguageSelect' });
      }
    }

    // add layer group
    this.mapLayerGroup.addTo(this.map);

    // choose random tutor
    const tutors = [
      {
        name: 'Linda',
        image: 'linda.png',
      },
      {
        name: 'Eliot',
        image: 'eliot.png',
      },
    ];
    this.tutor = tutors[Math.floor(Math.random() * tutors.length)];
  },

  created() {
    // key bindings
    const that = this;

    window.addEventListener('keyup', (event) => {
      if (event.keyCode === 72) {
        // bring modal back on h key press
        that.modalOpen = true;
      } else if (event.keyCode === 27) {
        // hide modal back on esc key press
        that.modalOpen = false;
      } else if (event.keyCode === 37) {
        // left arrow key => nav back
        this.$router.back();
        that.modalOpen = true;
      }
    });
  },

  components: {
    Map,
  },

  methods: {
    modalClose() {
      this.modalOpen = false;
    },

    removeLayers() {
      this.mapLayerGroup.eachLayer((layer2rm) => {
        this.mapLayerGroup.removeLayer(layer2rm);
      });
    },

    toggleReferencesVisibility() {
      this.referencesActive = !this.referencesActive;
    }
  },

  flyToOptions(maxZoom, duration, easeLinearity) {
    if (window.webpackHotUpdate) {
      duration = 0.1;
    }
    return {
      maxZoom,
      duration: duration || 3.0,
      easeLinearity: easeLinearity || 0.2,
    };
  },

  watch: {
    $route(to, from) {
      this.removeLayers();
      this.referencesActive = false;
    }
  }
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

  .flex {
      flex: 1;
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
  }

  .flex-end {
    align-self: flex-end;
  }

  .modal-bottom-center {
    top: unset;
  }

  .modal-bottom-right {
    top: unset;
    left: unset;
  }

  .helpButton {
    color: #74c476;
    font-size: 19px;
    font-weight: bolder;
  }
</style>
