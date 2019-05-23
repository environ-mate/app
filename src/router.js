import Vue from 'vue';
import Router from 'vue-router';

Vue.use(Router);


export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'EntryWelcome',
      component: () => import(/* webpackChunkName: "entry" */ './views/A01-EntryWelcome.vue'),
    },
    {
      path: '/welcome/hometown/',
      name: 'EntryHomeTownSelect',
      component: () => import(/* webpackChunkName: "entry" */ './views/A02-EntryHomeTownSelect.vue'),
    },
    {
      path: '/welcome/intro/',
      name: 'EntryIntro',
      component: () => import(/* webpackChunkName: "entry" */ './views/A03-EntryIntro.vue'),
    },
  ],
});
