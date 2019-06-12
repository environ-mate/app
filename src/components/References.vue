<i18n>
{
  "de": {
    "references": "Quellenangaben",
    "dataset": "Datensatz",
    "publisher": "Herausgeber",
    "version": "Version"
  },
   "en": {
    "references": "References",
    "dataset": "Dataset",
    "publisher": "Publisher",
    "version": "Version"
  }
}
</i18n>

<template>
  <div class="columns">
    <div class="column col-12">
      <h3>{{ $t('references') }}</h3>
      <table class="table table-striped table-hover">
        <thead>
          <tr>
            <th>{{ $t('dataset') }}</th>
            <th>{{ $t('publisher') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="ref in references" :key="ref.title">
            <td>
              <a :href="ref.link">
              {{ref.title}}
              </a>
            </td>
            <td>
              <img v-if="ref.publisherLogo" :src="ref.publisherLogo"/>
              <h5 v-if="ref.publisherName">{{ ref.publisherName }}</h5>
            </td>
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

  methods: {
  },
};
</script>

<style>
</style>
