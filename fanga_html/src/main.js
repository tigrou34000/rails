import Vue from 'vue'
import App from './App'
import Home from './components/Home.vue'
import TimeEntry from './components/TimeEntry.vue'
import LogTime from './components/LogTime.vue'

import VueRouter from 'vue-router'
import VueResource from 'vue-resource'


Vue.use(VueResource)
Vue.use(VueRouter)

const routes = [
    { path: '/home', component: Home },
    { path: '/time-entry', component: TimeEntry,
        children: [
            {
                path: 'log-time', component: LogTime
            }
        ]
    },
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