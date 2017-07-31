<template>
    <div v-if="!isLogin()">
        <label>Email : </label><input id="email" type="text" v-model="email">
        <label>password : </label><input id="password" type="text" v-model="password" >
        <button v-on:click="authentication()">Login</button>
    </div>
    <div v-else>
        Logué
        <button v-on:click="disconnect()">Deconnection</button>
    </div>

</template>
<script>
    import axios from 'axios';
    import store from '../store';
    export default {
    name:'login',
      data () {
        return {
                    token: store.state.token,
                    email: 'tiger63.thomas@gmail.com',
                    password: '011284',
                    name: '',
                    surname: ''
            }
        },
        methods: {
            isLogin() {
                return store.state.isLogin;
            },
            authentication() {
                axios.post("http://localhost:3000/authenticate", {
                    'email': this.email,
                    'password': this.password
                }).then(function(response) {
                    store.commit('login', {'email': email, 'token': response.data.auth_token});
                }).catch(function (error) {
                    console.log(error);
                });
                ;
            },
            disconnect() {
                store.commit('logout');
            }
        }
    }

</script>