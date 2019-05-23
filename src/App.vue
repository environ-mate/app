<template>
  <div id="app">
    <Map/>
    <router-view/>
  </div>
</template>

<script>
import Map from '@/components/Map.vue';

export default {
  name: 'App',

  data() {
    return {
      map: null,
      homeTownName: null,
      homeTownCoords: null,
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

  @media screen and (max-height: 640px) {
    .tutor {
      height: 85px;
    }
  }

  @media screen and (min-height: 640px) and (max-height: 667px) {
    .tutor {
      height: 100px;
    }
  }

  @media screen and (min-height: 667px) and (max-height: 736px) {
    .tutor {
      height: 220px;
    }
  }

  @media screen and (min-height: 736px) and (max-height: 768px) {
    .tutor {
      height: 280px;
    }
  }
</style>
