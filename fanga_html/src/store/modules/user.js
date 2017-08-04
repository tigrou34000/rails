import * as types from '../mutation-types'

const state = {
    user: {
        id: 0,
        email: '',
        name: '',
        surname: '',
        nickname: '',
        password: '',
        dob: '',
        isLogin: false,
        token: ''
    }
}
const getters = {
        isLogin: state => state.user.isLogin,
        getUser: state => state.user
}

const actions = {
    setUser({commit}, val) {
        console.log("user.js : action set user");
        commit(types.RECEIVE_USER, {val})
    },
    logout({commit}, val) {
        console.log("user.js : action set user");
        commit(types.RECEIVE_USER, {})
    },
    updateUser({commit}, val) {
        console.log("user.js : action update user");
        commit(types.UPDATE_USER, {val})
    },
}


// mutations
const mutations = {
    [types.RECEIVE_USER] (state, {val}) {
       if (typeof val != "undefined") {
            console.log("user.js : mutation receive user")
            state.user.email = val.email;
            state.user.token = val.token;
            state.user.id = val.user_id;
            state.user.isLogin = true;
        }else{
            state.user.email = '';
            state.user.token = '';
            state.user.id = '';
            state.user.isLogin = false;
        }
    },
    [types.UPDATE_USER] (state, {val}) {
        var user = state.user
        state.user =   Object.assign(user, val)

    }
}
export default {
    state,
    getters,
    actions,
    mutations
}
