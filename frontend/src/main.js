import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import VueRouter from 'vue-router'
import { router }  from './router' 


import '@mdi/font/css/materialdesignicons.css';


import { http } from './http.js'
Vue.prototype.$http = http 



Vue.config.productionTip = false



Vue.use(VueRouter);

new Vue({
  vuetify,
  router,
  render: h => h(App)
}).$mount('#app')


