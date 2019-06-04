import Vue from 'vue';
import Router from 'vue-router';
import EntryLanguageSelect from '@/views/A01-EntryLanguageSelect.vue';
import EntryWelcome from '@/views/A02-EntryWelcome.vue';
import EntryHomeTownSelect from '@/views/A03-EntryHomeTownSelect.vue';
import EntryIntro from '@/views/A04-EntryIntro.vue';
import GreenhouseEffect1 from '@/views/B01-GreenhouseEffect1.vue';
import GreenhouseEffect2 from '@/views/B02-GreenhouseEffect2.vue';
import GreenhouseEffect3 from '@/views/B03-GreenhouseEffect3.vue';
import GreenhouseEffect4 from '@/views/B04-GreenhouseEffect4.vue';
import GreenhouseEffect5 from '@/views/B05-GreenhouseEffect5.vue';
import GreenhouseEffect6 from '@/views/B06-GreenhouseEffect6.vue';
import ClimateChangeEffectsIntro from '@/views/C01-ClimateChangeEffectsIntro.vue';
import SeaLevelRiseIntro from '@/views/S01-SeaLevelRiseIntro.vue';
import SeaLevelRiseStory1 from '@/views/S02-SeaLevelRiseStory1.vue';


Vue.use(Router);


export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'A01-EntryLanguageSelect',
      component: EntryLanguageSelect,
    },
    {
      path: '/welcome/hello/',
      name: 'A02-EntryWelcome',
      component: EntryWelcome,
    },
    {
      path: '/welcome/hometown/',
      name: 'A03-EntryHomeTownSelect',
      component: EntryHomeTownSelect,
    },
    {
      path: '/welcome/intro/',
      name: 'A04-EntryIntro',
      component: EntryIntro,
    },
    {
      path: '/greenhouse-effect/intro-1/',
      name: 'B01-GreenhouseEffect1',
      component: GreenhouseEffect1,
    },
    {
      path: '/greenhouse-effect/intro-2/',
      name: 'B02-GreenhouseEffect2',
      component: GreenhouseEffect2,
    },
    {
      path: '/greenhouse-effect/intro-3/',
      name: 'B03-GreenhouseEffect3',
      component: GreenhouseEffect3,
    },
    {
      path: '/greenhouse-effect/intro-4/',
      name: 'B04-GreenhouseEffect4',
      component: GreenhouseEffect4,
    },
    {
      path: '/greenhouse-effect/explore/',
      name: 'B05-GreenhouseEffect5',
      component: GreenhouseEffect5,
    },
    {
      path: '/greenhouse-effect/explore_details/',
      name: 'B06-GreenhouseEffect6',
      component: GreenhouseEffect6,
    },
    {
      path: '/climate-change/effects/intro/',
      name: 'C01-ClimateChangeEffectsIntro',
      component: ClimateChangeEffectsIntro,
    },
    {
      path: '/climate-change/effects/sea-level-intro/',
      name: 'S01-SeaLevelRiseIntro',
      component: SeaLevelRiseIntro,
    },
    {
      path: '/climate-change/effects/story/1/',
      name: 'SeaLevelRiseStory1',
      component: SeaLevelRiseStory1,
    },
  ],
});
