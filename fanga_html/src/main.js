import Vue from 'vue'
import App from './App'


import Home from './components/Home.vue'

import Login from './components/LoginDiv.vue'
import Subscription from './components/Subscription.vue'

import VueRouter from 'vue-router'
import VueResource from 'vue-resource'


Vue.use(VueResource)
Vue.use(VueRouter)

const routes = [
    { path: '/home', component: Home },
    {  path: '/user', component:Login, name: 'user.index'},
    {  path: '/user/create-user', component:Subscription, name: 'user.create'},
    {  path: '/user/edit-user', component:Subscription, name: 'user.update'},
    { path: '*', redirect: '/home' },
];

const router = new VueRouter({
    routes, // short for routes: routes
    mode: 'history'
});

var bus = new Vue({});

/* eslint-disable no-new */
const app = new Vue({
        router,
        data: {
            bus:bus
        },
        render: h => h(App)
}).$mount('#app')