import Vue from 'vue';
import Router from 'vue-router';
import EntryLanguageSelect from '@/views/A01-EntryLanguageSelect.vue';
import EntryWelcome from '@/views/A02-EntryWelcome.vue';
import EntryHomeTownSelect from '@/views/A03-EntryHomeTownSelect.vue';
import EntryIntro from '@/views/A04-EntryIntro.vue';
import GreenhouseEffect from '@/views/B01-GreenhouseEffect.vue';

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
      path: '/greenhouse-effect/intro/',
      name: 'B01-GreenhouseEffect',
      component: GreenhouseEffect,
    },
  ],
});
