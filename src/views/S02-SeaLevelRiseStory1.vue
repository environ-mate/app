<i18n>
{
  "de": {
    "title": "Anstieg des Meeresspiegels am Beispiel Aveiro in Portugal",
    "next_btn": "weiter"
  }
}
</i18n>

<template>
  <div class="modal modal modal-bottom" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right"
           aria-label="Close"></a>

        <div class="modal-title h4 flex-centered">
           {{ $t("title") }}
        </div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-5">
            TODO: bla bla bla
          </div>
          <div class="column col-5">
            <img class="img-responsive" src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Aveiro_%2825260330524%29.jpg/800px-Aveiro_%2825260330524%29.jpg">
          </div>
        </div>
      </div>
      <div class="modal-footer">
       <div class="columns">
          <div class="column col-1 flex-centered">
            <button @click="navBack" class="btn btn-lg btn float-left"><i class="icon icon-arrow-left"></i></button>
          </div>
          <div class="column col-8 flex-centered">
          </div>
          <div class="column col-3 flex-centered">
            <button @click="next" class="btn btn-lg btn-success float-right"> {{ $t('next_btn') }}<i class="icon icon-arrow-right"></i></button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as d3 from 'd3';
import L from 'leaflet';
import Colors from '@/utils/colors';


export default {
  mounted() {
    this.$parent.removeLayers();
    this.$parent.$data.map.flyTo(
      [40.64123, -8.65391], 9, this.$parent.$options.flyToOptions(11),
    );

    const style = {
      color: Colors.red,
      weight: 0,
      opacity: 1.0,
    };

    d3.json('/data/tmp/2100_europe.geojson').then((geoJSON) => {
      L.geoJson(geoJSON, {
        style,
      }).addTo(this.$parent.$data.mapLayerGroup);
    });
  },

  methods: {
    next() {
      this.$router.push({ name: 'S025-SeaLevelRiseStory1' });
    },

    modalClose() {
      this.$parent.modalClose();
    },

    navBack() {
      this.$router.back();
    },
  },
};
</script>

<style scoped>
  .modal-bottom {
    top: unset;
    left: unset;
  }
</style>
