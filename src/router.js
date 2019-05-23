import Vue from 'vue';
import Router from 'vue-router';

Vue.use(Router);


const locale = window.location.pathname.replace(/^\/([^/]+).*/i, '$1');

export default new Router({
  mode: 'history',
  base: (locale.trim().length && locale !== '/') ? `/${locale}` : undefined,
  routes: [
    {
      path: '/',
      name: 'A01-EntryLanguageSelect',
      component: () => import(/* webpackChunkName: "entry" */ './views/A01-EntryLanguageSelect.vue'),
    },
    {
      path: '/welcome/hello/',
      name: 'A02-EntryWelcome',
      component: () => import(/* webpackChunkName: "entry" */ './views/A02-EntryWelcome.vue'),
    },
    {
      path: '/welcome/hometown/',
      name: 'A03-EntryHomeTownSelect',
      component: () => import(/* webpackChunkName: "entry" */ './views/A03-EntryHomeTownSelect.vue'),
    },
    {
      path: '/welcome/intro/',
      name: 'A04-EntryIntro',
      component: () => import(/* webpackChunkName: "entry" */ './views/A04-EntryIntro.vue'),
    },
  ],
});
