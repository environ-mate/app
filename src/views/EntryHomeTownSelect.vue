<template>
  <div class="modal" v-bind:class="{ active: modalOpen }">
      <div class="modal-container">
        <div class="modal-header">
          <a @click="modalClose" class="btn btn-clear float-right"
             aria-label="Close"></a>
          <div class="modal-title h5">
            🏡  Verrate mir als erstes den Namen der Stadt in der du wohnst
          </div>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <div class="form-autocomplete">
              <div class="form-autocomplete-input form-input">
                <div class="has-icon-left">
                  <input v-model="city2GeoCode" ref="city2GeoCode" @input="doCity2GeoCode"
                         class="form-input" type="text" size="50" style="width: 100%"
                         placeholder="gebe hier den Namen deines Wohnortes ein">
                  <i class="form-icon" v-bind:class="{ loading: city2GeoCodeIsLoading }"></i>
                </div>
              </div>
            </div>
          </div>
          <ul class="menu" v-bind:class="{ hide: !citySuggestions.length }">
            <li v-for="(suggestion, index) in citySuggestions" class="menu-item">
              <a @click="selectCity(index)">
                <div class="tile tile-centered">
                  <div class="tile-content">
                    <span v-html="(suggestion.matchLevel === 'city' && suggestion.address.city)
                      || (suggestion.matchLevel === 'district' && suggestion.address.district)">
                    </span>,
                    <span v-html="suggestion.address.postalCode"></span>,
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
import axios from 'axios';
import omnivore from 'leaflet-omnivore/leaflet-omnivore';

export default {
  name: 'EntryHomeTownSelect',

  data() {
    return {
      modalOpen: true,
      city2GeoCode: '',
      city2GeoCodeIsLoading: false,
      citySuggestions: [],
    };
  },
  mounted () {
    this.$refs.city2GeoCode.focus();
  },
  methods: {
    modalClose() {
      this.modalOpen = false;
    },

    doCity2GeoCode() {
      this.citySuggestions = [];

      this.$nextTick(() => {
        if (this.city2GeoCode.length < 2) {
          return;
        }

        this.city2GeoCodeIsLoading = true;

        // get cities for autocomplete
        axios.get(
          `http://autocomplete.geocoder.api.here.com/6.2/suggest.json?app_id=7gCIVwMlioSBU1tFJoeg&app_code=SWuBVOU9R325PSRgsuxFIQ&query=${this.city2GeoCode}&beginHighlight=<mark>&endHighlight=</mark>&resultType=areas&maxresults=10`,
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
            this.city2GeoCodeIsLoading = false;
          });
      });
    },

    selectCity(index) {
      this.city2GeoCodeIsLoading = true;
      const { locationId } = this.citySuggestions[index];

      // get selected city polygon
      axios.get(
        `https://geocoder.api.here.com/6.2/geocode.json?locationid=${locationId}&gen=9&app_id=7gCIVwMlioSBU1tFJoeg&app_code=SWuBVOU9R325PSRgsuxFIQ&maxresults=1&additionaldata=IncludeShapeLevel,city`,
      )
        .then((response) => {
          // const jsonLayer = L.geoJson(response.data, {

          // style: {
          //   weight: 0,
          //   fillColor: '#00ad79',
          //   fillOpacity: 0.3
          // },

          // onEachFeature(feature, layer) {
          // layer.bindPopup("<strong>" + feature.properties['DISTRICT'])
          // },

          // });

          const jsonLayer = omnivore.wkt.parse(
            response.data.Response.View[0].Result[0].Location.Shape.Value,
          );

          jsonLayer.style = {
            weight: 0,
            fillColor: '#00ad79',
            fillOpacity: 0.3,
          };

          this.modalOpen = false;

          this.$parent.$data.map.flyToBounds(
            jsonLayer.getBounds(), this.$parent.$options.flyToOptions(10),
          );

          this.$parent.$data.map.once('moveend', () => {
            jsonLayer.addTo(this.$parent.$data.map);
          });
        })
        .catch((error) => {
          console.log(error);
        })
        .finally(() => {
          this.city2GeoCodeIsLoading = false;
        });
    },
  },
};
</script>
