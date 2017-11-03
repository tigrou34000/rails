import Vuex from 'vuex'
import Vue from 'vue'
import * as actions from './actions'
import * as getters from './getters'
import error from './modules/error'
import user from './modules/user'


Vue.use(Vuex)
const debug = process.env.NODE_ENV !== 'production'


export default new Vuex.Store({
    actions,
    getters,
    modules: {
        error,
        user
    },
    strict: debug
})
