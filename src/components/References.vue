<i18n>
{
  "de": {
    "dataset": "Datensatz",
    "source": "Quelle"
  },
   "en": {
    "dataset": "Dataset",
    "source": "Source"
  }
}
</i18n>

<template>
  <div class="columns">
    <div class="column col-12">
      <h3>Quellenangaben</h3>
      <table class="table table-striped table-hover">
        <thead>
          <tr>
            <th>{{ $t('dataset') }}</th>
            <th>{{ $t('source') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="ref in referencesData" :key="ref.title">
            <td>
              <a :href="ref.link">
              {{ref.title}}
              </a>
            </td>
            <td>{{ref.sourceName}} <img :src="ref.sourceLogo"></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';

import 'leaflet-easybutton/src/easy-button';
import 'leaflet-easybutton/src/easy-button.css';

export default {
  name: 'References',

  props: ['references'],

  computed: {
    referencesData(){
        console.log(this.references);
        return this.references;
    }
  },

  methods: {
  },
};
</script>

<style>
</style>
