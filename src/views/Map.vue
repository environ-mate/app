<template>
  <div class="map-workspace">
    <div class="modal" v-bind:class="{ active: modalOpen }">

      <div v-if="screen==='welcome'" class="modal-container">
        <div class="modal-body">
          <center>
            <h4>Howdi! 🖐 Mein Name ist Eliot. </h4>
            <h5>Ich begleite dich ab jetzt hier.</h5>
            <img class="img-responsive" src="eliot.png"/>
            <h5>Du kannst zu jeder Zeit die <i><b>h</b></i> Taste drücken. Ich komme dir dann zu Hilfe geeilt 🐢  💨</h5>
            <p>
              <br/>
              <button v-on:click="switchScreen('inputCity')" class="btn btn-success">Klicke hier um zu starten!</button>
            </p>
          </center>
        </div>
      </div>

      <div v-if="screen==='inputCity'" class="modal-container">
        <div class="modal-header">
          <a v-on:click="modalClose" href="#close" class="btn btn-clear float-right"
             aria-label="Close"></a>
          <div class="modal-title h5">
            Verrate mir als erstes den Namen der Stadt in der du wohnst
          </div>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <div class="form-autocomplete">
              <div class="form-autocomplete-input form-input is-focused">
                <div class="has-icon-left">
                  <input v-model="city2GeoCode" ref="city2GeoCode" class="form-input" type="text"
                         placeholder="🏡  gebe hier den Namen deines Wohnortes ein" style="width: 100%;"
                  ><i class="form-icon" v-bind:class="{ loading: city2GeoCode }"></i>
                </div>
              </div>
              <ul class="menu hide">
                <li class="menu-item"><a href="#autocomplete">
                  <div class="tile tile-centered">
                    <div class="tile-content">
                      <mark>S</mark>
                      teve Roger
                      <mark>s</mark>
                    </div>
                  </div>
                </a></li>
                <li class="menu-item"><a href="#autocomplete">
                  <div class="tile tile-centered">
                    <div class="tile-icon">
                      <figure class="avatar avatar-sm" data-initial="TS" style="background-color: #5755d9;"></figure>
                    </div>
                    <div class="tile-content">Tony
                      <mark>S</mark>
                      tark
                    </div>
                  </div>
                </a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>

    </div>

    <div id="map"></div>
  </div>
</template>

<script>
import axios from 'axios';
import L from 'leaflet';
import 'leaflet-fullscreen/dist/Leaflet.fullscreen';
import 'leaflet-fullscreen/dist/leaflet.fullscreen.css';
import 'leaflet/dist/leaflet.css';

export default {
  name: 'map-workspace',
  data() {
    return {
      screen: 'welcome',
      map: null,
      modalOpen: true,
      city2GeoCode: null,
    };
  },
  mounted() {
    this.initMap();
  },
  methods: {
    initMap() {
      this.map = L.map('map', {
        fullscreenControl: {
          pseudoFullscreen: false,
        },
      })
        .setView([51.5, -0.09], 4);


      L.tileLayer('http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, &copy; <a href="http://cartodb.com/attributions">CartoDB</a>',
      })
        .addTo(this.map);
    },

    switchScreen(screen) {
      this.screen = screen;
    },

    modalClose() {
      this.modalOpen = false;
      // this.$refs.city2GeoCode.$el.focus();

      axios.get('https://nominatim.openstreetmap.org/?q=Feldafing&format=geojson&polygon_geojson=1&limit=1')
        .then((response) => {
          const jsonLayer = L.geoJson(response.data, {

            style: { weight: 0, fillColor: '#00ad79', fillOpacity: 0.3 },

            onEachFeature(feature, layer) {
              // layer.bindPopup("<strong>" + feature.properties['DISTRICT'])
            },

          });
          jsonLayer.addTo(this.map);
          this.map.flyToBounds(jsonLayer.getBounds(), { maxZoom: 11, duration: 3.0, easeLinearity: 0.2 });
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>

<style>
  #map, .map-workspace {
    z-index: 0;
    height: 100%;
    width: 100%;
  }

  .hide {
    display:none;
  }
</style>
