<template>
  <div id="app">
    <Map/>
    <router-view/>
  </div>
</template>

<script>
import Map from '@/components/Map.vue';
import L from 'leaflet';
import 'spectre.css';
import 'spectre.css/dist/spectre-icons.css';
import 'spectre.css/dist/spectre-exp.css';
import 'vue-i18n/dist/vue-i18n';
import 'c3/c3.css';

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
    };
  },

  mounted() {
    if (this.tutor === null) {
      this.removeLayers();
      this.$router.push({ name: 'A01-EntryLanguageSelect' });
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
  },

  flyToOptions(maxZoom, duration, easeLinearity) {
    return {
      maxZoom,
      duration: duration || 3.0,
      easeLinearity: easeLinearity || 0.2,
    };
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

  .flex {
      flex: 1;
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
  }

  .flex-end {
    align-self: flex-end;
  }

  .modal-body, .modal-container {
    height: max-content;
  }
</style>
