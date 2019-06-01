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
import WIP from '@/views/Z00-WIP.vue';

Vue.use(Router);


const locale = window.location.pathname.replace(/^\/([^/]+).*/i, '$1');

export default new Router({
  mode: 'history',
  base: (locale.trim().length && locale !== '/') ? `/${locale}` : undefined,
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
      path: '/wip/',
      name: 'Z00-WIP',
      component: WIP,
    },
  ],
});
