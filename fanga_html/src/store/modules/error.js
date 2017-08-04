import * as types from '../mutation-types'

const state = {
    errors: []
}

const getters = {
        getErrors: state => state.errors
}

const actions = {
    setErrors({commit}, val) {
        console.log("error.js : action set error");
        commit(types.RECEIVE_ERRORS, {val})
    }
}

// mutations
const mutations = {
    [types.RECEIVE_ERRORS] (state, { val}) {
        console.log("error.js : mutation receive error")
        state.errors = val
    }
}
export default {
    state,
    getters,
    actions,
    mutations
}
