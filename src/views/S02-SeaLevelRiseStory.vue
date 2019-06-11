<i18n>
{
  "de": {
    "title": "Anstieg des Meeresspiegels am Beispiel {storyName}",
    "desc": "Einige Regionen werden stark vom Anstieg des Meeresspiegels betroffen sein. Hier kannst du dir eine Simulation in vier Küstenregionen ansehen. Durch aufwändige und sehr teure Maßnahmen, wie dem Bau von Dämmen, kann eine Überflutung unter Umständen verhindert werden.",
    "story_name_aveiro": "Aveiro, Portugal",
    "story_desc_aveiro":"Große Teile der Lagune von Aveiro liegen bereits unter dem Meeresspiegel und werden nur durch die Barrieren der Salinen, die seit dem 15. Jahrhundert dort sind, vor Überschwemmungen geschützt. Diese Barrieren werden jedoch meist nicht mehr aufrecht erhalten und könnten eines tages versagen. Hier zeigen wir die erwartete Überschwemmung ohne diese Barrieren - auch heute noch würden mehr von der Lagune unter Wasser stehen!",
    "story_name_foulness": "Foulness Island, UK",
    "story_name_uzlina": "Uzlina, Rumänien",
    "story_name_the_broads": "The Broads, UK",
    "story_name_netherlands": " Niederlande",
    "photo_popup": "Hier wurde das Foto aufgenommen",
    "photo_cc_license": "ist lizenziert unter CC BY 2.0",
    "next_btn": "weiter"
  },
  "en": {
    "title": "Example of sea level rise in {storyName}",
    "desc": "Some regions will be severely affected by sea-level rise. Here you can see a simulation of four coastal regions. Flooding can be prevented under certain circumstances by expensive construction measures such as dams.",
    "story_name_aveiro": "Aveiro, Portugal",
    "story_desc_aveiro":"Large parts of the Aveiro lagoon already sit below sea-level, and are only prevented from flooding by the barriers of salt pans that have been there since the 15th century. However, these barriers are mostly no longer maintained, and are expected to fail at some point. Here we show the expected flooding without these barriers – even today more of the lagoon would be submerged!",
    "story_name_foulness": "Foulness Island, UK",
    "story_name_uzlina": "Uzlina, Romania",
    "story_name_the_broads": "The Broads, UK",
    "story_name_netherlands": "Netherlands",
    "photo_popup": "The photo was taken here",
    "photo_cc_license": "is licensed under CC BY 2.0",
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
        <References v-if="$parent.$data.referencesActive" :references="references"/>

        <div v-if="!$parent.$data.referencesActive" class="columns">
          <div class="column col-6">
            <div class="btn-group btn-group-block">
                <button @click="renderYear(y)" v-for="y in years" :key="y" :class="{ 'active': y === year  }" class="btn btn-action btn-sm">{{ y }}</button>
            </div>
            <p></p>
          </div>
          <div class="column col-6"></div>

          <div class="column col-7">
            {{ $t('desc') }}
          </div>
          <div class="column col-5">
            <img v-if="this.storySelectedData.imageURL" class="img-responsive" :src="this.storySelectedData.imageURL">
            <em v-if="this.storySelectedData.imageURL">
              <a :href="this.storySelectedData.imageCopyrightLink" target="_blank">{{ this.storySelectedData.imageCopyrightText }}</a>,
              <a href="https://creativecommons.org/licenses/by/2.0/" target="_blank">{{ $t("photo_cc_license") }}</a>
            </em>
          </div>
        </div>
      </div>
      <div class="modal-footer">
       <div class="columns">
          <div class="column col-2 flex-centered">
            <button @click="navBack" class="btn btn-lg btn float-left"><i class="icon icon-arrow-left"></i></button>
            <a @click="$parent.toggleReferencesVisibility" class="btn btn-lg float-left"><i class="icon" v-bind:class="[$parent.$data.referencesActive ? 'icon-cross' : 'icon-message']"></i></a>
          </div>
          <div class="column col-7 flex-centered">
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
import '@/vendors/leaflet-svgicon/svg-icon';
import References from '@/components/References.vue';

export default {
  components: {
    References,
  },

  data() {
    return {
      year: 2010,
      years: [2010, 2040, 2070, 2100],
      stories: {
        aveiro: {
          name: this.$t('story_name_aveiro'),
          coords: [40.7323, -8.65391],
          zoomLevel: 11,
          imageLocation: [40.661995, -8.647931],
          imageURL: '/assets/sealevel_rise_story/aveiro.jpg',
          imageCopyrightText: 'Sergei G.',
          imageCopyrightLink: 'https://www.flickr.com/photos/sergeigussev/',
        },
        foulness: {
          name: this.$t('story_name_foulness'),
          coords: [51.60542714, 0.8507641],
          zoomLevel: 12,
          imageLocation: [51.5855078, 0.8701842],
          imageURL: '/assets/sealevel_rise_story/foulness.jpg',
          imageCopyrightText: 'Trevor H.',
          imageCopyrightLink: 'https://www.geograph.org.uk/profile/27744',
        },
        uzlina: {
          name: this.$t('story_name_uzlina'),
          coords: [44.9885519, 29.5160797],
          zoomLevel: 10,
          imageLocation: null,
          imageURL: '/assets/sealevel_rise_story/uzlina.jpg',
          imageCopyrightText: 'F.Micki',
          imageCopyrightLink: 'https://www.flickr.com/photos/f_micki/',
        },
        the_broads: {
          name: this.$t('story_name_the_broads'),
          coords: [52.633363, 1.709751],
          zoomLevel: 11,
          imageLocation: [52.7004576, 1.6675209],
          imageURL: '/assets/sealevel_rise_story/the_broads.jpg',
          imageCopyrightText: 'Richard L.',
          imageCopyrightLink: 'https://www.geograph.org.uk/profile/25319',
        },
        netherlands: {
          name: this.$t('story_name_netherlands'),
          coords: [52.5387303, 5.2920731],
          zoomLevel: 8,
          imageLocation: null,
          imageURL: null,
          imageCopyrightText: null,
          imageCopyrightLink: null,
        },
      },
      storySelectedId: 'foulness',
      storySelectedData: null,
      storyImageMapLayerGroup: L.layerGroup().addTo(this.$parent.$data.map),
      storyGeoData: null,
      loop: null,
    };
  },

  created() {
    this.removeLayers();
    this.changeStory();
  },

  mounted() {
    // set up stuff for the default story
    this.$parent.removeLayers();
  },

  destroyed() {
    this.$parent.removeLayers();
    this.removeLayers();
    this.animationStop();
  },

  methods: {
    removeLayers() {
      this.storyImageMapLayerGroup.eachLayer((layer2rm) => {
        this.storyImageMapLayerGroup.removeLayer(layer2rm);
      });
    },

    animationStop() {
      clearInterval(this.loop);
    },

    changeStory() {
      // prefetch story geo data
      this.storyGeoData = {};

      this.storySelectedData = this.stories[this.storySelectedId];
      this.year = Math.min(...this.years);

      this.removeLayers();
      this.animationStop();

      this.$parent.$data.map.flyTo(
        this.storySelectedData.coords, this.storySelectedData.zoomLevel, this.$parent.$options.flyToOptions(60),
      );

      // add story photo marker to map
      if (this.storySelectedData.imageLocation) {
        new L.Marker.SVGMarker(L.latLng(...this.storySelectedData.imageLocation), { iconOptions: { color: Colors.orange, fillOpacity: 0.8 } }).addTo(this.storyImageMapLayerGroup)
          .bindPopup(this.$t('photo_popup'))
          .openPopup();
      }

      const promises = [];

      for (const year of this.years) {
        const promise = d3.json(`/data/sea_level_rise_stories/${this.storySelectedId}/${year}.geojson`).then((geoJSON) => {
          this.storyGeoData[year] = geoJSON;
        });
        promises.push(promise);
      }

      const that = this;

      function looper() {
        let yearIndexNext = that.years.indexOf(that.year);
        if (yearIndexNext + 1 > that.years.length - 1) {
          yearIndexNext = 0;
        } else {
          yearIndexNext += 1;
        }
        that.year = that.years[yearIndexNext];
        that.renderYear();
      }

      Promise.all(promises).then(() => {
        // animation loop
        that.loop = setInterval(looper, 800);
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

      L.geoJson(this.storyGeoData[this.year], {
        weight: 0,
        fillColor: Colors.blue,
        fillOpacity: 0.5,
      }).addTo(this.$parent.$data.mapLayerGroup);
    },

    next() {
      this.$router.push({ name: 'C01-ClimateChangeEffectsIntro' });
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
