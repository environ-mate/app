<i18n>
{
  "de": {
    "title": "Was geschieht mit unserem Wetter?",
    "vis_title": "Naturkatastrophen in der EU und Russland 1970 - 2018",
    "vis_legend_storm": "Sturm",
    "vis_legend_wildfire": "Flächenbrand",
    "vis_legend_flood": "Überschwemmung",
    "vis_legend_drought": "Dürre",
    "desc": "Überschwemmungen, Dürren, Hitzewellen und andere klimabedingte Extreme verursachten zwischen 1980 und 2017 Schäden in Höhe von 453 Milliarden Euro und forderten über 115.000 Menschenleben in ganz Europa. Die Grafik auf der rechten Seite zeigt wie in den letzten Jahren die Anzahl der wetterbedingten Naturkatastrophen zugenommen hat seit den 80er Jahren. Frühe Messungen mögen unvollständig sein aber man sieht in den letzten Jahren einen deutlichen anstieg. Wir können erwarten, dass sowohl die Häufigkeit als auch die Schwere von Stürmen und Überschwemmungen im Laufe der Zeit zunehmen werden, was Eigentum und Leben bedroht.",
    "next_btn": "Übersicht Auswirkungen"
  },
  "en": {
    "title": "What is happening with our weather?",
    "vis_title": "Natural Catastrophes in the EU and Russia 1970 - 2018",
    "vis_legend_storm": "Storm",
    "vis_legend_wildfire": "Wildfire",
    "vis_legend_flood": "Flood",
    "vis_legend_drought": "Drought",
    "desc": "Floods, droughts, heatwaves, and other climate-related extremes caused €453 billion in damages between 1980 and 2017, killing over 115,000 people across Europe. The graph on the right demonstrates how the number of extreme weather catastrophes has increased since the 80ies. Early measurements might be not completely documented but we see a clear increase in the last decades. We can expect both the frequency and severity of storms and floods to rise as time goes on, threatening property and lives.",
    "next_btn": "Overview Consequences"
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
        <References v-if="$parent.$data.referencesActive" :references="references"/>

        <div v-if="!$parent.$data.referencesActive" class="columns">
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
            <a @click="$parent.toggleReferencesVisibility" class="btn btn-lg float-left"><i class="icon" v-bind:class="[$parent.$data.referencesActive ? 'icon-cross' : 'icon-message']"></i></a>
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
import References from '@/components/References.vue';

export default {
  components: {
    VueC3,
    References,
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
