<template>
  <div id="app">
    <Map/>
    <router-view/>
  </div>
</template>

<script>
import Map from '@/components/Map.vue'

export default {
  name: 'App',

  data: function() {
    return {
      map: null,
    };
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
</style>
