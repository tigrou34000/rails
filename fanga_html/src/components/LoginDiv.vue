<template>
    <div v-if="!isLogin">
        <label>Email : </label><input id="email" type="text" v-model="email">
        <label>password : </label><input id="password" type="text" v-model="password" >
        <button v-on:click="authentication()">Login</button>
    </div>
    <div v-else>
        Logué
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
                    surname: '',
                    isLogin: store.state.isLogin
            }
        },
        methods: {

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
            }
        }
    }

</script>