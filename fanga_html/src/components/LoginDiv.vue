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
    export default {
    name:'login',
      data () {
        return {
                    token: '',
                    email: '',
                    password: '',
                    name: '',
                    surname: '',
                    isLogin: false
            }
        },
        methods: {
            setCookie(name, value, exdays) {
                var d = new Date();
                d.setTime(d.getTime() +  (exdays*24*60*60*1000) ) ;
                var expires = "expires="+ d.toUTCString();
                document.cookie = '"'+name+'='+value+';'+expires;
            },
            authentication() {
                axios.post("http://localhost:3000/authenticate", {
                    'email': this.email,
                    'password': this.password
                }).then(function(response) {
                    Login.token = response.data.auth_token;
                    isLogin = true;
                    this.setCookie("auth_token", token , 1);
                    
                }).catch(function (error) {
                    console.log(error);
                });
                ;
            }
        }
    }

</script>