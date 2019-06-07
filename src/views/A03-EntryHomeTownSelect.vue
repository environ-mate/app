<i18n>
{
  "de": {
    "title": "In welcher Stadt wohnst du?",
    "input_placeholder": "Gebe hier den Namen deines Wohnortes ein",
    "popup": "Deine Heimatstadt %{city}"
  },
  "en": {
    "title": "Which city do you live in?",
    "input_placeholder": "Please enter the name of your place of residence",
    "popup": "Your hometown %{city}"
  }
}
</i18n>

<template>
  <div class="modal" v-bind:class="{ active: modalOpen }">
      <div class="modal-container">
        <div class="modal-header">
          <div class="modal-title h5">
            🏡 {{ $t("title") }}
          </div>
        </div>
        <div class="modal-body">
          <div class="columns">
            <div class="column col-10 flex-centered">
              <div class="form-group">
                <div class="form-autocomplete">
                  <div class="form-autocomplete-input form-input">
                    <div class="has-icon-left">
                      <input v-model="city2geoCode" ref="city2geoCode" @input="doCity2GeoCode"
                             class="form-input" type="text" size="50" style="width: 100%"
                             :placeholder="$t('input_placeholder')">
                      <i class="form-icon" v-bind:class="{ loading: city2geoCodeIsLoading }"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="column col-2 flex-centered">
              <img class="img-responsive" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
            </div>
          </div>
          <ul class="menu" v-bind:class="{ 'd-hide': !citySuggestions.length }">
            <li v-for="(suggestion, index) in citySuggestions" class="menu-item" v-bind:key="index">
              <a @click="selectCity(index)" class="c-hand">
                <div class="tile tile-centered">
                  <div class="tile-content">
                    <span v-html="(suggestion.matchLevel === 'city' && suggestion.address.city)
                      || (suggestion.matchLevel === 'district' && suggestion.address.district)">
                    </span>,
                    <span v-html="suggestion.address.country"></span>
                  </div>
                </div>
              </a>
            </li>
          </ul>
        </div>
      </div>
  </div>
</template>

<script>
import L from 'leaflet';
import Colors from '@/utils/colors';
import Helper from '@/utils/helper';
import axios from 'axios';
import omnivore from 'leaflet-omnivore/leaflet-omnivore';

export default {
  data() {
    return {
      modalOpen: true,
      city2geoCode: '',
      city2geoCodeIsLoading: false,
      citySuggestions: [],
    };
  },

  mounted() {
    this.$refs.city2geoCode.focus();
  },

  methods: {
    modalClose() {
      this.modalOpen = false;
    },

    doCity2GeoCode() {
      this.$nextTick(() => {
        this.citySuggestions = [];
        this.city2geoCodeIsLoading = true;

        // get cities for autocomplete
        axios.get(
          `http://autocomplete.geocoder.api.here.com/6.2/suggest.json?app_id=7gCIVwMlioSBU1tFJoeg&app_code=SWuBVOU9R325PSRgsuxFIQ&query=${this.city2geoCode}&beginHighlight=<mark>&endHighlight=</mark>&resultType=areas&maxresults=10`,
        )
          .then((response) => {
            if (!response.data.suggestions) {
              return;
            }

            this.citySuggestions = response.data.suggestions.filter(s => s.matchLevel === 'district' || s.matchLevel === 'city');
          })
          .catch((error) => {
            console.log(error);
          })
          .finally(() => {
            this.city2geoCodeIsLoading = false;
          });
      });
    },

    selectCity(index) {
      this.city2geoCodeIsLoading = true;
      const { locationId } = this.citySuggestions[index];

      // get selected city polygon
      axios.get(
        `https://geocoder.api.here.com/6.2/geocode.json?locationid=${locationId}&gen=9&app_id=7gCIVwMlioSBU1tFJoeg&app_code=SWuBVOU9R325PSRgsuxFIQ&maxresults=1&additionaldata=IncludeShapeLevel,city`,
      )
        .then((response) => {
          const location = response.data.Response.View[0].Result[0].Location;

          let layer = L.geoJson(null, {
            style() {
              return {
                weight: 2,
                color: Colors.blue,
                opacity: 0.9,
                fillColor: Colors.blue,
                fillOpacity: 0.3,
              };
            },
          });

          this.$parent.$data.homeTownCoords = [location.DisplayPosition.Latitude, location.DisplayPosition.Longitude];
          this.$parent.$data.homeTownName = location.Address.District || location.Address.City;
          this.$parent.$data.homeTownCountryCode = location.Address.Country;
          this.$parent.$data.homeTownCountryName = location.Address.AdditionalData.filter(d => d.key === 'CountryName')[0].value;

          this.modalOpen = false;

          // fly to city
          layer = omnivore.wkt.parse(location.Shape.Value, null, layer);

          this.$parent.$data.map.flyToBounds(
            layer.getBounds(), this.$parent.$options.flyToOptions(11),
          );

          this.$parent.removeLayers();

          this.$parent.$data.map.once('moveend', () => {
            layer.addTo(this.$parent.$data.mapLayerGroup);

            new L.Marker.SVGMarker(L.latLng(...this.$parent.$data.homeTownCoords), { iconOptions: { color: Colors.orange, fillOpacity: 0.8 }}).addTo(this.$parent.$data.mapLayerGroup)
              .bindPopup(this.$t('popup', { city: this.$parent.$data.homeTownName }))
              .openPopup();

            Helper.sleep(5, () => {
              this.$router.push({ name: 'A04-EntryIntro' });
            });
          });
        })
        .catch((error) => {
          console.log(error);
        })
        .finally(() => {
          this.city2geoCodeIsLoading = false;
        });
    },
  },
};
</script>
