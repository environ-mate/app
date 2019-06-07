<i18n>
{
  "de": {
    "title": "Was geschieht mit unserem Wetter?",
    "vis_title": "TODO",
    "vis_legend_storm": "Sturm",
    "vis_legend_wildfire": "Flächenbrand",
    "vis_legend_flood": "Überschwemmung",
    "vis_legend_drought": "Dürre",
    "desc": "TODO",
    "next_btn": "Übersicht"
  },
  "en": {
    "title": "",
    "vis_title": "",
    "vis_legend_storm": "Storm",
    "vis_legend_wildfire": "Wildfire",
    "vis_legend_flood": "Flood",
    "vis_legend_drought": "Drought",
    "desc": "",
    "next_btn": "Overview"
  }
}
</i18n>

<template>
  <div class="modal modal-xl" v-bind:class="{ active: this.$parent.$data.modalOpen }">
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
          <div class="column col-4">
            <p>{{ $t('desc') }}</p>
          </div>
          <div class="column col-1 flex">
            <img class="img-responsive flex-end" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
          <div class="column col-7">
            <h5>{{ $t('vis_title', {homeTown: this.$parent.$data.homeTownCountryName, year: this.year}) }}</h5>
            <vue-c3 :handler="chart"></vue-c3>
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
import Vue from 'vue';
import VueC3 from 'vue-c3';
import Mappings from '@/utils/mappings';
import Colors from '@/utils/colors';

export default {
  components: {
    VueC3,
  },

  data() {
    return {
      chart: new Vue(),
      year: null,
    };
  },



  mounted() {
    this.chart.$emit('init', {
      x: 'year',
      data: {
        url: '/data/extreme_weather_occurences.csv',
        x: 'year',
        names: {
          'storm.occurrence': this.$t('vis_legend_storm'),
          'wildfire.occurrence': this.$t('vis_legend_wildfire'),
          'flood.occurrence': this.$t('vis_legend_flood'),
          'drought.occurrence': this.$t('vis_legend_drought'),
        },
        type: 'area',
        colors: {
          'storm.occurrence': Colors.purple,
          'wildfire.occurrence': Colors.orange,
          'flood.occurrence': Colors.blue,
          'drought.occurrence': Colors.brown,
        },
      },
    });
  },

  methods: {
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
