import Vuex from 'vuex'
import Vue from 'vue'

Vue.use(Vuex)

var store = new Vuex.Store({
    state: {
        email: '',
        password:'',
        isLogin:false,
        token:'',
        timeEntries: [],
        totalTime: 0,
    },
   /* methods: {
        setCookie(name, value, exdays) {
            var d = new Date();
            d.setTime(d.getTime() +  (exdays*24*60*60*1000) ) ;
            var expires = "expires="+ d.toUTCString();
            document.cookie = '"'+name+'='+value+';'+expires;
        },
    },*/
    mutations: {
        login(state, aLogin) {
            state.email = aLogin.email.value;
            state.token = aLogin.token;
            state.isLogin = true;
          //  state.setCookie('auth_token', aLogin.token, 1);
        },
        logout(state) {
            state.email = '';
            state.token ='';
            state.isLogin = false;
        },

        timeUpdate(state,timeEntry) {
            state.totalTime += timeEntry.totalTime;
            state.timeEntries.push(timeEntry);
        },
        deleteTime(state,timeEntry) {
            let index = state.timeEntries.indexOf(timeEntry);
            state.timeEntries.splice(index, 1);
            state.totalTime -= timeEntry.totalTime;
        }
    }
})

export default store