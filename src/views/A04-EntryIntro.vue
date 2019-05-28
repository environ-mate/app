<i18n>
{
  "de": {
    "title": "Klimawandel, was ist das eigentlich?!",
    "intro_1": "Du hast sicher schon mal vom Klimawandel gehört.",
    "intro_2": "Was hat es damit eigentlich auf sich?",
    "intro_3": "In deiner Heimatstadt %{homeTown} bla bla bla",
    "chart_degress": "Durchschnittstemperaturen",
    "chart_degress_desc": "Europäische Durchschnittstemperaturen über Land im Vergleich zur vorindustriellen Zeit"
  }
}
</i18n>

<template>
  <div class="modal modal-lg" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right"
           aria-label="Close"></a>

        <button @click="navBack" class="btn btn-lg btn-action float-left"><i class="icon icon-arrow-left"></i></button>

        <div class="modal-title h3 flex-centered">
           {{ $t("title") }}
        </div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-12">
            {{ $t("intro_1") }}<br/>
            {{ $t("intro_2") }}<br/>
            {{ $t("intro_3", { homeTown: this.$parent.$data.homeTownName }) }}<br/>
            {{ $t("chart_degress_desc") }}<br/>
          </div>
          <div class="column col-12 divider"/>
          <div id="chart" class="column col-9"/>
          <div class="column col-3">
            <img class="img-responsive" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import 'c3/c3.css';
import c3 from 'c3/c3';

export default {
  name: 'EntryIntro',

  mounted() {
    c3.generate({
      bindto: '#chart',
      x: 'year',
      data: {
        url: '/data/eu_average_temperatures_anual_diff.csv',
        x: 'year',
        names: {
          hadcrut4: this.$t('chart_degress'),
        },
        type: 'bar',
        colors: {
          hadcrut4: (d) => {
            if (d.value < 0) {
              return '#6baed6';
            }
            return '#fb6a4a';
          },
        },
      },
      bar: {
        width: {
          ratio: 1.0,
        },
      },
      axis: {
        y: {
          max: 2.4,
          min: -0.5,
          label: {
            text: '°C',
            position: 'outer-middle',
          },
        },
      },
    });
  },

  methods: {
    next() {
      this.$router.push({ name: 'A03-EntryHomeTownSelect' });
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

<style>
  #chart .c3-line {
    stroke-width: 1.5px;

  }
</style>
