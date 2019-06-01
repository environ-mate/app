<i18n>
{
  "de": {
    "title": "Was ist eigentlich mit Treibhauseffekt gemeint? 🔆",
    "desc_1": "Um die Erde ist eine Lufthülle, die man Atmosphäre nennt.",
    "desc_2": "Darin gibt es verschiedene Gase von denen einige Sonnenlicht zur Erde durchlassen aber die Wärme zurückhalten",
    "desc_3": "Das ist ähnlich wie in einem Gewächshaus (Treibhaus) und deshalb nennt man diese Gase auch Treibhausgase.",
    "earth": "Erde",
    "atmosphere": "Atmosphäre",
    "greenhouse_gases": "Treibhausgase",
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

        <div class="modal-title h4 flex-centered">
           {{ $t("title") }}
        </div>
      </div>
      <div class="modal-body">
        <div class="columns">
          <div class="column col-7 flex-centered">
            <object type="image/svg+xml">
              <svg width="446px" height="425px" viewBox="0 0 446 425" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                  <defs>
                      <linearGradient x1="50%" y1="0%" x2="50%" y2="100%" id="linearGradient-1">
                          <stop stop-color="#FFFFFF" stop-opacity="0.5" offset="0%"></stop>
                          <stop stop-color="#000000" stop-opacity="0.5" offset="100%"></stop>
                      </linearGradient>
                      <linearGradient x1="50%" y1="0%" x2="50%" y2="100%" id="linearGradient-2">
                          <stop stop-color="#FFFFFF" stop-opacity="0.5" offset="0%"></stop>
                          <stop stop-color="#000000" stop-opacity="0.5" offset="100%"></stop>
                      </linearGradient>
                  </defs>
                  <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                      <g id="Group-5" transform="translate(4.000000, 3.000000)">
                          <g id="Group-2" transform="translate(133.250000, 113.100000)">
                              <g id="Group" transform="translate(81.069444, 81.081081)">
                                  <ellipse id="Oval" fill="#74C476" cx="64.8555556" cy="64.8648649" rx="64.8555556" ry="64.8648649"></ellipse>
                                  <text id="Erde" fill="#FFFFFF" font-family="Arial-BoldMT, Arial" font-size="16.25" font-weight="bold">
                                      <tspan x="46.7925062" y="70.7648649">{{ $t('earth') }}</tspan>
                                  </text>
                              </g>
                              <ellipse id="Oval" stroke="#67A9CF" stroke-width="32.5" cx="145.925" cy="145.945946" rx="145.925" ry="145.945946"></ellipse>
                              <text id="Atmosphäre" fill="#000000" font-family="Arial-BoldMT, Arial" font-size="16.25" font-weight="bold">
                                  <tspan x="98.8449097" y="245.1">{{ $t('atmosphere') }}</tspan>
                              </text>
                              <text id="Treibhausgase" fill="#FFFFFF" font-family="Arial-BoldMT, Arial" font-size="14.95" font-weight="bold">
                                  <tspan x="93.5781006" y="292.235135">{{ $t('greenhouse_gases') }}</tspan>
                              </text>
                          </g>
                          <path id="Line" d="M231.962306,43.8908301 L224.015164,56.5257866 L221.264103,54.7954226 L234.052183,34.4639799 L244.786728,55.9505368 L241.879367,57.4030355 L235.208394,44.0502342 L226.443342,222.540823 L223.197254,222.381418 L231.962306,43.8908301 Z" fill="#FC8D59" fill-rule="nonzero"></path>
                          <path id="Line" d="M265.988552,187.104183 L264.43045,172.259268 L267.662695,171.920016 L270.169903,195.807596 L248.453629,185.545724 L249.842169,182.60728 L263.337728,188.984511 L227.103174,137.902252 L229.753998,136.021924 L265.988552,187.104183 Z" fill="#FC8D59" fill-rule="nonzero"></path>
                          <path id="Line" d="M213.800822,206.923646 L206.738811,182.667227 L212.979694,180.850257 L225.124936,222.566434 L183.16744,211.283047 L184.855473,205.006062 L209.252211,211.566935 L102.977171,107.458883 L107.525782,102.815594 L213.800822,206.923646 Z" fill="#FC8D59" fill-rule="nonzero"></path>
                          <g id="Group-4">
                              <g id="Group-3" transform="translate(39.490121, 39.489474)" fill="#FFEDA0">
                                  <ellipse id="Oval" cx="40.4611895" cy="40.4605263" rx="40.4611895" ry="40.4605263"></ellipse>
                              </g>
                              <path d="M79.9513105,-0.00131048387 L79.9513105,159.90131" id="Line-2" stroke="#FFEDA0" stroke-width="6.5" stroke-linecap="square" transform="translate(79.951310, 79.950000) rotate(90.000000) translate(-79.951310, -79.950000) "></path>
                              <path d="M64.007094,7.36131865 L62.7132644,119.356963" id="Line-2" stroke="#FFEDA0" stroke-width="6.5" stroke-linecap="square" transform="translate(63.360179, 63.359141) rotate(-45.000000) translate(-63.360179, -63.359141) "></path>
                              <path d="M80.5986895,0.323684211 L80.5986895,159.576316" id="Line-2" stroke="#FFEDA0" stroke-width="6.5" stroke-linecap="square"></path>
                              <path d="M80.0692973,0.116674372 L80.0679868,160.017985" id="Line-2" stroke="#FFEDA0" stroke-width="6.5" stroke-linecap="square" transform="translate(80.068642, 80.067330) rotate(45.000000) translate(-80.068642, -80.067330) "></path>
                          </g>
                      </g>
                  </g>
              </svg>
            </object>
          </div>
          <div class="column col-4">
            <p>{{ $t('desc_1') }}</p>
            <p>{{ $t('desc_2') }}</p>
            <p>{{ $t('desc_3') }}</p>
          </div>
          <div class="column col-1 flex">
            <img class="img-responsive flex-end" v-bind:src="'/assets/wimmel/' + this.$parent.$data.tutor.image"/>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <div class="columns">
          <div class="column col-1 flex-centered">
            <button @click="navBack" class="btn btn-lg btn float-left"><i class="icon icon-arrow-left"></i></button>
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
export default {
  methods: {
    next() {
      this.$router.push({ name: 'B02-GreenhouseEffect2' });
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
