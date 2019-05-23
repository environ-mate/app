<template>
  <div id="app">
    <Map/>
    <router-view/>
  </div>
</template>

<script>
import Map from '@/components/Map.vue';
import 'spectre.css';
import 'spectre.css/dist/spectre-exp.css';
import 'vue-i18n/dist/vue-i18n';

export default {
  name: 'App',

  data() {
    return {
      map: null,
      homeTownName: null,
      homeTownCoords: null,
      tutor: null,
    };
  },

  mounted() {
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

  components: {
    Map,
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

  .modal-body, .modal-container {
    height: max-content;
  }

  .hide {
    display:none;
  }

  .emoji {
    font-size: 1.8em;
  }
</style>
