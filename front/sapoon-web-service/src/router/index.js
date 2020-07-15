import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Seoul from '../views/Seoul.vue'
import Kakao from '../views/Kakao.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/sapoon/web',
    name: 'Home',
    component: Home
  },
  {
    path: '/sapoon/web/map/seoul',
    name: 'Seoul',
    component: Seoul
  },
  {
    path: '/sapoon/web/map/kakao',
    name: 'Kakao',
    component: Kakao
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
