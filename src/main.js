import Vue from 'vue';
import VueI18n from 'vue-i18n';
import App from './App.vue';
import router from './router';
import store from './store';


Vue.config.productionTip = false;

Vue.use(VueI18n);

const locale = window.location.pathname.replace(/^\/([^/]+).*/i, '$1');
const fallbackLocale = 'en';

const i18n = new VueI18n({
  locale: fallbackLocale,
});

new Vue({
  i18n,
  router,
  store,
  render: h => h(App),
}).$mount('#app');
