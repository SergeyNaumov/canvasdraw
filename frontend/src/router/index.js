
import VueRouter from 'vue-router'
import Lk from '/src/Lk.vue'
import Login from '/src/Login.vue'



const routes=[
  {
    path:'/login',
    name:'Login',
    component: Login
  },
  {
    path:'/lk',
    name:'Lk',
    component: Lk
  },
  {
    path:'/test',
    name:'test',
    component:{template:'<div>test</div>'}
  }
]


export const router = new VueRouter({
  mode: 'history',
  routes: routes
})



