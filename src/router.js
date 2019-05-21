import Vue from 'vue';
import Router from 'vue-router';
import App from './App.vue';

const EntryIntro = () => import(/* webpackChunkName: "entry" */ './views/EntryIntro.vue');
const EntryHomeTownSelect = () => import(/* webpackChunkName: "entry" */ './views/EntryHomeTownSelect.vue');


Vue.use(Router);


export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'Map',
      component: App,
    },
    {
      path: '/welcome/into/',
      name: 'EntryIntro',
      component: EntryIntro,
    },
    {
      path: '/welcome/hometown/',
      name: 'EntryHomeTownSelect',
      component: EntryHomeTownSelect,
    },
  ],
});
