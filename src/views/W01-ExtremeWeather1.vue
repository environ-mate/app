<i18n>
{
  "de": {
    "title": "Was geschieht mit unserem Wetter?",
    "vis_title": "Extremwetter in Europa 1960 - 2019",
    "vis_legend_drought": "Dürren",
    "vis_legend_extreme_temperature": "Hitzewellen",
    "vis_legend_flood": "Überschwemmungen",
    "vis_legend_landslide": "Lawinen",
    "vis_legend_storm": "Stürme",
    "vis_legend_wildfire": "Waldbrände",
    "desc": "Dürren, Hitzewellen, Überschwemmungen, Lawinen, Stürme und Waldbrände verursachten zwischen 1960 und 2019 Schäden in Höhe von etwa 313 Milliarden Dollar und forderten über 162.000 Menschenleben in ganz Europa. Die Grafik auf der rechten Seite zeigt wie die Anzahl der Extremwetterereignisse seit den 1980er Jahren zugenommen hat. Frühe Messungen mögen unvollständig sein aber man sieht in den letzten Jahren einen deutlichen Anstieg. Wir können erwarten, dass sowohl die Häufigkeit als auch die Schwere von Extremwetterereignissen im Laufe der Zeit zunehmen werden, was Leben und Eigentum bedroht.",
    "next_btn": "Übersicht Auswirkungen"
  },
  "en": {
    "title": "What is happening with our weather?",
    "vis_title": "Extreme weather in Europe 1960 - 2019",
    "vis_legend_drought": "Droughts",
    "vis_legend_extreme_temperature": "Heatwaves",
    "vis_legend_flood": "Floods",
    "vis_legend_landslide": "Landslides",
    "vis_legend_storm": "Storms",
    "vis_legend_wildfire": "Wildfires",
    "desc": "Droughts, heatwaves, floods, landslides, storms and wildfires caused around 313 billion dollars in damages between 1960 and 2019, killing over 162,000 people across Europe. The graph on the right demonstrates how the number of extreme weather events has increased since the 1980ies. Early measurements might be not completely documented but we see a clear increase in the last decades. We can expect both the frequency and severity of extrem weather events to rise as time goes on, threatening lives and property.",
    "next_btn": "Overview Consequences"
  }
}
</i18n>

<template>
  <div class="modal modal-xl" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right" aria-label="Close"></a>

        <div class="modal-title h4">{{ $t("title") }}</div>
      </div>
      <div class="modal-body">
        <References v-if="$parent.$data.referencesActive" :references="references" />

        <div v-else class="columns">
          <div class="column col-4 col-md-10">
            <p>{{ $t('desc') }}</p>
          </div>
          <div class="column col-2 col-md-2">
            <img
              class="img-responsive"
              v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"
            />
          </div>
          <div class="column col-6 col-md-12">
            <h5>{{ $t('vis_title', {homeTown: this.$parent.$data.homeTownCountryName, year: this.year}) }}</h5>
            <vue-c3 :handler="chart"></vue-c3>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="columns">
          <div class="column col-6 text-left">
            <div class="btn-group">
              <button @click="navBack" class="btn btn-lg btn">
                <i class="icon icon-arrow-left"></i>
              </button>
              <button @click="$parent.toggleReferencesVisibility" class="btn btn-lg">
                <i
                  class="icon"
                  v-bind:class="[$parent.$data.referencesActive ? 'icon-cross' : 'icon-message']"
                ></i>
              </button>
            </div>
          </div>
          <div class="column col-6 text-right">
            <button @click="next" class="btn btn-lg btn-success">
              {{ $t('next_btn') }}
              <i class="icon icon-arrow-right"></i>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as d3 from "d3";
import Vue from "vue";
import VueC3 from "vue-c3";
import Mappings from "@/utils/mappings";
import Colors from "@/utils/colors";
import References from "@/components/References.vue";

export default {
  components: {
    VueC3,
    References
  },

  data() {
    return {
      chart: new Vue(),
      year: null
    };
  },

  updated() {
    this.renderChart();
  },

  mounted() {
    this.renderChart();
  },

  methods: {
    renderChart() {
      this.chart.$emit("init", {
        x: "year",
        data: {
          url: "/data/extreme_weather/extreme_weather_occurrences_europe_since_1960.csv",
          x: "year",
          names: {
            "drought.occurrence": this.$t("vis_legend_drought"),
            "extreme.temperature.occurrence": this.$t("vis_legend_extreme_temperature"),
            "flood.occurrence": this.$t("vis_legend_flood"),
            "landslide.occurrence": this.$t("vis_legend_landslide"),
            "storm.occurrence": this.$t("vis_legend_storm"),
            "wildfire.occurrence": this.$t("vis_legend_wildfire")
          },
          type: "area",
          colors: {
            "drought.occurrence": Colors.purple,
            "extreme.temperature.occurrence": Colors.orange,
            "flood.occurrence": Colors.blue,
            "landslide.occurrence": Colors.brown,
            "storm.occurrence": Colors.green,
            "wildfire.occurrence": Colors.red
          }
        }
      });
    },

    next() {
      this.$router.push({ name: "C01-ClimateChangeEffectsIntro" });
    },

    modalClose() {
      this.$parent.modalClose();
    },

    navBack() {
      this.$router.back();
    }
  }
};
</script>
