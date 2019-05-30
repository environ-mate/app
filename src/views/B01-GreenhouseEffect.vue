<i18n>
{
  "de": {
    "title": "Der Treibhauseffekt  🔆",
    "next_btn": "weiter"
  }
}
</i18n>

<template>
  <div class="modal modal-lg" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
      <div class="modal-header">
        <a @click="modalClose" class="btn btn-clear float-right"
           aria-label="Close"></a>

        <div class="modal-title h3 flex-centered">
           {{ $t("title") }}
        </div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-12">

          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="columns">
          <div class="column col-1 flex-centered">
            <button @click="navBack" class="btn btn-lg btn float-left"><i class="icon icon-arrow-left"></i></button>
          </div>
          <div class="column col-8 flex-centered">
            {{ $t('next_desc') }}
          </div>
          <div class="column col-3 flex-centered">
            <button @click="navBack" class="btn btn-lg btn-success float-right"> {{ $t('next_btn') }}<i class="icon icon-arrow-right"></i></button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from 'vue';

export default {
  name: 'EntryIntro',

  data() {
    return {
      chart: new Vue(),
    };
  },

  mounted() {
    this.chart.$emit('init', {
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
          ratio: 1.2,
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
