<i18n>
{
  "de": {
    "title": "Anstieg des Meeresspiegels am Beispiel Aveiro in Portugal",
    "next_btn": "weiter"
  }
}
</i18n>

<template>
  <div class="modal modal modal-bottom-right" v-bind:class="{ active: this.$parent.$data.modalOpen }">
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
          <div class="column col-7">
            TODO: bla bla bla
          </div>
          <div class="column col-5">
            <img class="img-responsive" src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Aveiro_%2825260330524%29.jpg/800px-Aveiro_%2825260330524%29.jpg">
          </div>

          <div class="column col-6">
            <div class="btn-group btn-group-block">
              <button @click="renderYear(y)" v-for="y in years" :key="y" :class="{ 'active': y === year  }" class="btn btn-action btn-sm">{{ y }}</button>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
       <div class="columns">
          <div class="column col-1 flex-centered">
            <button @click="navBack" class="btn btn-lg btn float-left"><i class="icon icon-arrow-left"></i></button>
          </div>
          <div class="column col-8 flex-centered">
            <select v-model="storySelected" class="form-select">
              <option v-for="(story, storyId) in stories" v-bind:value="storyId" v-bind:key="storyId">{{ story.name }}</option>
            </select>
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

//const waterLayerStyle = ;

export default {
  data() {
    return {
      year: 2010,
      years: [2010, 2040, 2070, 2100],
      stories: {
        aveiro: {
          name: 'Aveiro in Portugal',
        },
      },
      storySelected: 'aveiro',
    };
  },

  mounted() {
    this.$parent.removeLayers();
    this.renderYear();
    this.$parent.$data.map.flyTo(
      [40.7323, -8.65391], 12, this.$parent.$options.flyToOptions(11),
    );
  },

  methods: {
    renderYear(year) {
      if (year) {
        this.year = year;
      }
      this.year = parseInt(this.year, 10);

      if (this.years.indexOf(this.year) < 0) {
        return;
      }

      this.$parent.removeLayers();

      d3.json(`/data/sea_level_rise_stories/${this.storySelected}/${this.year}.geojson`).then((geoJSON) => {
        L.geoJson(geoJSON, {
          weight: 0,
          fillColor: Colors.blue,
          fillOpacity: 0.5,
        }).addTo(this.$parent.$data.mapLayerGroup);
      });
    },

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

</style>
