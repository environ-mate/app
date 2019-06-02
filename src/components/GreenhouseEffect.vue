<i18n>
{
  "de": {
    "earth": "Erde",
    "atmosphere": "Atmosphäre",
    "greenhouse_gases": "Treibhausgase"
  }
}
</i18n>

<template>
<svg width="430px" height="409px" viewBox="0 0 430 409" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
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
                    <circle id="Oval" fill="#74C476" cx="61.5" cy="61.5" r="61.5"></circle>
                    <text id="Erde" fill="#FFFFFF" font-family="Arial-BoldMT, Arial" font-size="15.4375" font-weight="bold">
                        <tspan x="44.3401031" y="67">{{ $t('earth') }}</tspan>
                    </text>
                </g>
                <circle v-bind:class="{ atmosphereAnimation: animate }" id="Oval" stroke-opacity="0.6" stroke="#67A9CF" stroke-width="30.875" cx="138.5" cy="138.5" r="138.5"></circle>
                <text id="Atmosphäre" fill="#000000" font-family="Arial-BoldMT, Arial" font-size="15.4375" font-weight="bold">
                    <tspan x="93.4651642" y="233">{{ $t('atmosphere') }}</tspan>
                </text>
                <text id="Treibhausgase" fill="#FFFFFF" font-family="Arial-BoldMT, Arial" font-size="14.2025" font-weight="bold">
                    <tspan x="89.2704456" y="277">{{ $t('greenhouse_gases') }}</tspan>
                </text>
            </g>
            <path id="Line" d="M233.558775,57.6577045 L225.588804,69.4284601 L223.032225,67.6974024 L235.750564,48.9138369 L245.580363,69.3577491 L242.797799,70.6956556 L236.637938,57.8844407 L230.507826,141.133691 L227.428662,140.906955 L233.558775,57.6577045 Z" fill="#FC8D59" fill-rule="nonzero"></path>
            <path id="Line" d="M261.491053,189.575913 L261.596385,175.361131 L264.6838,175.384009 L264.515713,198.067708 L244.999151,186.505603 L246.572837,183.849258 L258.802926,191.094672 L229.028531,138.395525 L231.716658,136.876765 L261.491053,189.575913 Z" fill="#FC8D59" fill-rule="nonzero"></path>
            <path id="Line" d="M213.704496,209.657483 L206.876995,184.626858 L213.292611,182.876896 L225.074296,226.070286 L182.182525,213.233891 L184.089145,206.863075 L208.944981,214.301782 L99.5367292,102.179349 L104.296244,97.5350493 L213.704496,209.657483 Z" fill="#FC8D59" fill-rule="nonzero"></path>
            <g id="Group-4">
                <g id="Group-3" transform="translate(37.515615, 37.515000)" fill="#FED976">
                    <ellipse id="Oval" cx="38.43813" cy="38.4375" rx="38.43813" ry="38.4375"></ellipse>
                </g>
                <path d="M75.953745,-0.00124495968 L75.953745,151.906245" id="Line-2" stroke="#FED976" stroke-width="6.175" stroke-linecap="square" transform="translate(75.953745, 75.952500) rotate(90.000000) translate(-75.953745, -75.952500) "></path>
                <path d="M60.8067393,6.99325272 L59.5776012,113.389115" id="Line-2" stroke="#FED976" stroke-width="6.175" stroke-linecap="square" transform="translate(60.192170, 60.191184) rotate(-45.000000) translate(-60.192170, -60.191184) "></path>
                <path d="M76.568755,0.3075 L76.568755,151.5975" id="Line-2" stroke="#FED976" stroke-width="6.175" stroke-linecap="square"></path>
                <path d="M76.0658324,0.110840653 L76.0645874,152.017086" id="Line-2" stroke="#FED976" stroke-width="6.175" stroke-linecap="square" transform="translate(76.065210, 76.063963) rotate(45.000000) translate(-76.065210, -76.063963) "></path>
            </g>
        </g>
        <polyline id="Line-3" stroke="#FC8D59" stroke-width="6.65" stroke-linecap="square" points="233 143 229.932864 184.917525 227 225"></polyline>
    </g>
</svg>
</template>

<script>

export default {
  name: 'GreenhouseEffect',
  props: ['animate'],
};
</script>

<style scoped>
  @keyframes atmosphere {
    0% {
      stroke-opacity: 0.4;
    }
    100% {
      stroke-opacity: 1.0;
    }
  }

  .atmosphereAnimation {
     animation: atmosphere 3s infinite;
  }
</style>
