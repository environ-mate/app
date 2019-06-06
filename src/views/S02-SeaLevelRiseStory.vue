<i18n>
{
  "de": {
    "title": "Anstieg des Meeresspiegels am Beispiel {storyName}",
    "story_name_aveiro": "Aveiro, Portugal",
    "story_name_foulness": "Foulness Island, UK",
    "story_name_sa_pobla": "Sa Pobla, Spanien",
    "story_name_uzlina": "Uzlina, Rumänien",
    "next_btn": "weiter"
  },
  "en": {
    "title": "Example of sea level rise in {storyName}",
    "story_name_aveiro": "Aveiro, Portugal",
    "story_name_foulness": "Foulness Island, UK",
    "story_name_sa_pobla": "Sa Pobla, Spain",
    "story_name_uzlina": "Uzlina, Romania",
    "next_btn": "continue"
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
           {{ $t("title", {'storyName': this.storySelectedData.name}) }}
        </div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-6">
            <div class="btn-group btn-group-block">
                <button @click="renderYear(y)" v-for="y in years" :key="y" :class="{ 'active': y === year  }" class="btn btn-action btn-sm">{{ y }}</button>
            </div>
            <p></p>
          </div>
          <div class="column col-6"></div>

          <div class="column col-7">
            TODO: 123
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
            <select v-model="storySelectedId" @change="changeStory" @mousedown="animationStop" @click="animationStop" class="form-select">
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


export default {
  data() {
    return {
      year: 2010,
      years: [2010, 2040, 2070, 2100],
      stories: {
        aveiro: {
          name: this.$t('story_name_aveiro'),
          coords: [40.7323, -8.65391],
          zoomLevel: 12,
        },
        sa_pobla: {
          name: this.$t('story_name_sa_pobla'),
          coords: [39.77093, 3.02727],
          zoomLevel: 12,
        },
        foulness: {
          name: this.$t('story_name_foulness'),
          coords: [51.6042714, 0.8407641],
          zoomLevel: 13,
        },
        uzlina: {
          name: this.$t('story_name_uzlina'),
          coords: [44.9885519, 29.2160797],
          zoomLevel: 11,
        },
      },
      storySelectedId: 'aveiro',
      storySelectedData: null,
      loop: null,
    };
  },

  created() {
    // set up stuff for the default story
    this.changeStory();
  },

  mounted() {
    this.$parent.removeLayers();
  },

  destroyed() {
    this.$parent.removeLayers();
    this.animationStop();
  },

  methods: {
    animationStop() {
      if (this.loop) {
        clearInterval(this.loop);
      }
    },

    changeStory() {
      this.storySelectedData = this.stories[this.storySelectedId];
      this.year = Math.min(...this.years);

      this.$parent.$data.map.flyTo(
        this.storySelectedData.coords, this.storySelectedData.zoomLevel, this.$parent.$options.flyToOptions(60),
      );

      this.$parent.$data.map.once('moveend', () => {
        this.loop = setInterval(() => {
          let yearIndexNext = this.years.indexOf(this.year);
          if (yearIndexNext + 1 > this.years.length - 1) {
            yearIndexNext = 0;
          } else {
            yearIndexNext = yearIndexNext + 1;
          }
          this.year = this.years[yearIndexNext];
          this.renderYear();
        }, 800);
      });
    },

    renderYear(year) {
      if (year) {
        this.animationStop();
        this.year = year;
      }

      this.year = parseInt(this.year, 10);
      if (this.years.indexOf(this.year) < 0) {
        return;
      }

      this.$parent.removeLayers();

      d3.json(`/data/sea_level_rise_stories/${this.storySelectedId}/${this.year}.geojson`).then((geoJSON) => {
        L.geoJson(geoJSON, {
          weight: 0,
          fillColor: Colors.blue,
          fillOpacity: 0.5,
        }).addTo(this.$parent.$data.mapLayerGroup);
      });
    },

    next() {
      this.$router.push({ name: 'Z01-ActOverview' });
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
