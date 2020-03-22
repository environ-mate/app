<i18n>
{
  "de": {
    "title": "Klimawandel, was ist das eigentlich?",
    "intro_1": "Du hast sicher schon mal vom Klimawandel gehört. Was hat es damit auf sich?",
    "intro_2": "In den letzten Jahrzehnten hat sich die Durchschnittstemperatur auf unserer Erde drastisch erhöht. 1-2 Grad hören sich dabei wenig an, haben aber einen großen Effekt auf unsere Umwelt.",
    "chart_degress_desc": "Schaut man sich die Abweichung der Durchschnittstemperaturen in Europa im Vergleich zur Zeit vor 1900 an, sieht man wie gerade die letzten Jahre immer wärmer wurden:",
    "chart_degress": "Temperaturabweichung vom Durchschnitt vor der Industrialisierung (1900)",
    "next_desc": "Aber wieso hat sich die Erde auf einmal erwärmt?",
    "next_next_desc": "Das erkläre ich dir auf den nächsten Seiten.",
    "next_btn": "Start Erklärung Klimawandel"
  },
  "en": {
    "title": "What is climate change?",
    "intro_1": "You've likely heard of climate change. So, what's it all about?",
    "intro_2": "In recent decades the average temperature of earth has dramatically increased.  1-2 degrees doesn't sound like much, but has a very high impact on our environment.",
    "chart_degress_desc": "If you take a look at the average temperatures in Europe and compare it to before 1900, you can see it is becoming hotter and hotter:",
    "chart_degress": "Temperature deviation from pre industrial average (1900)",
    "next_desc": "But why the increase in temperatures on earth?",
    "next_next_desc": "I'll explain that to you over the next pages.",
    "next_btn": "Start explanation of climate change"
  }
}
</i18n>

<template>
  <div class="modal modal-xl" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header align-center">
        <a @click="modalClose" class="btn btn-clear float-right" aria-label="Close"></a>

        <div class="modal-title h4">{{ $t('title') }}</div>
      </div>
      <div class="modal-body">
        <References v-if="$parent.$data.referencesActive" :references="references" />

        <div v-else>
          <p>
            {{ $t('intro_1') }}
            <br />
            {{ $t('intro_2') }}
          </p>

          <h6>{{ $t('chart_degress_desc') }}</h6>

          <div class="columns align-center mb-3 py-2">
            <div class="entryIntro-chart column col-sm-12 col-10 px-2">
              <vue-c3 :handler="chart"></vue-c3>
            </div>
            <div class="column col-sm-12 col-2 text-center">
              <img
                class="img-responsive"
                width="160"
                v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"
              />
            </div>
          </div>

          <div class="d-flex flex-wrap align-center">
            <div class="flex-1 pr-2 mr-2 mb-2" style="min-width:250px">
              {{ $t('next_desc') }}
              <br />
              {{ $t('next_next_desc') }}
            </div>
            <div class>
              <button @click="next" class="btn btn-lg btn-success btn-multiline">
                {{ $t('next_btn') }}
                <i class="icon icon-arrow-right"></i>
              </button>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer" style="text-align:left">
        <div class="btn-group">
          <button @click="navBack" class="btn btn-lg btn tooltip" data-tooltip="Back">
            <i class="icon icon-arrow-left"></i>
          </button>
          <button
            @click="$parent.toggleReferencesVisibility"
            class="btn btn-lg tooltip"
            data-tooltip="Reference"
          >
            <i
              class="icon"
              v-bind:class="[$parent.$data.referencesActive ? 'icon-cross' : 'icon-message']"
            ></i>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Colors from "@/utils/colors";
import Vue from "vue";
import VueC3 from "vue-c3";
import References from "@/components/References.vue";

export default {
  components: {
    References,
    VueC3
  },

  data() {
    return {
      chart: new Vue(),
      references: [
        {
          title: "Global and European temperature",
          link:
            "https://www.eea.europa.eu/data-and-maps/indicators/global-and-european-temperature-8/assessment",
          publisherName: null,
          publisherLogo: "/assets/data_source_publishers/eea.png"
        }
      ]
    };
  },

  mounted() {
    this.renderChart();
  },

  updated() {
    this.renderChart();
  },

  methods: {
    renderChart() {
      this.chart.$emit("init", {
        x: "year",
        size: {
          height: 280
        },
        data: {
          url: "/data/temperature/european_land_temperature_deviations_annual.csv",
          x: "year",
          names: {
            "temperature.deviation.degree.celcius": this.$t("chart_degress")
          },
          type: "bar",
          colors: {
            "temperature.deviation.degree.celcius": d => {
              if (d.value < 0) {
                return Colors.blue;
              }
              return Colors.red;
            }
          }
        },
        bar: {
          width: {
            ratio: 1.2
          }
        },
        axis: {
          y: {
            max: 2.4,
            min: -0.5,
            label: {
              text: "°C",
              position: "outer-middle"
            }
          }
        }
      });
    },

    next() {
      this.$router.push({ name: "B01-GreenhouseEffect1" });
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


<style>
.entryIntro-chart .c3-grid {
  height: 10px;
}
@media (max-width: 480px) {
  .entryIntro-chart .c3-legend-item {
    display: none;
  }
  .entryIntro-chart .tick:nth-child(odd) text {
    transform: translateY(10px);
  }
}
</style>
