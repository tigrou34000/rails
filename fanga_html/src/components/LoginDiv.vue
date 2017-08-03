<template>
    <div v-if="!isLogin()">
        <label>Email : </label><input id="email" type="text" v-model="email">
        <label>password : </label><input id="password" type="text" v-model="password" >
        <button v-on:click="authentication()">Login</button>
        <router-link :to="{name:'user.create'}" class="nav-link">create account</router-link>
        <router-link to="/user/create-user">created account</router-link>
    </div>
    <div v-else>
        Logué
        <button v-on:click="disconnect()">Disconnect</button>
        <router-link to="/user/edit-user">edit account</router-link>
    </div>

</template>
<script>
    import axios from 'axios';
    import store from '../store';
    export default {
    name:'login',
      data () {
        return {
                    email: 'tiger63.thomas@gmail.com',
                    password: '011284',
            }
        },
        methods: {
            isLogin() {
                return store.state.user.isLogin;
            },
            authentication() {
                axios.post("http://localhost:3000/authenticate", {
                    'email': this.email,
                    'password': this.password
                }).then(function(response) {
                    store.commit('login', {'email': email, 'token': response.data.auth_token, 'user_id': response.data.user_id});
                }).catch(function (error) {
                    for(var err in error.response.data.error) {
                         var a = {}
                         a[err] = error.response.data.error[err][0]
                        this.$store.dispatch('setErrors', a);
                    }
                });
                ;
            },
            disconnect() {
                store.commit('logout');
            }
        }
    }

</script>