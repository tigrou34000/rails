import Vuex from 'vuex'
import Vue from 'vue'

Vue.use(Vuex)

var store = new Vuex.Store({
    state: {
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
    },
    mutations: {
        login(state, aLogin) {
            state.user.email = aLogin.email.value;
            state.user.token = aLogin.token;
            state.user.id = aLogin.user_id;
            state.user.isLogin = true;
          //  state.setCookie('auth_token', aLogin.token, 1);
        },
        logout(state) {
            state.user.id = 0;
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