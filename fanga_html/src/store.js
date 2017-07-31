import Vuex from 'vuex'
import Vue from 'vue'

Vue.use(Vuex)

var store = new Vuex.Store({
    state: {
        user: {
            email: '',
            name: '',
            surname: '',
            nickname: '',
            password: '',
            dob: '',
            isLogin: false,
            token: ''
        }
    },
    mutations: {
        login(state, aLogin) {
            state.user.email = aLogin.email.value;
            state.user.token = aLogin.token;
            state.user.isLogin = true;
          //  state.setCookie('auth_token', aLogin.token, 1);
        },
        logout(state) {
            state.user.email = '';
            state.user.token ='';
            state.user.isLogin = false;
        },
        updateUser(state, user) {
            state.user = user;
        }
    }
})

export default store