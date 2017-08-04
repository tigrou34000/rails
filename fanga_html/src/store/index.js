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
    strict: debug,
  /*  state: {
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
        },
        errors:{}
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
        },
        setErrors(state, error) {
            for(var err in error) {
               state.errors[err] = error[err]
            }
        }
    }*/
})
