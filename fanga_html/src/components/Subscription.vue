<template>
    <div>
    <label>name</label>
    <input type="text" id="name"  v-model="eventObj.name">
    <label>surname</label>
    <input type="text" id="surname" v-model="eventObj.surname">
    <label>nickname</label>
    <input type="text" id="nickname" v-model="eventObj.nickname">
    <label>Date of birthday</label>
    <input type="text" id="dob" v-model="eventObj.dob">

    <label>password</label>
    <input type="password" id="password"  v-model="eventObj.password">
    <label>password confirmation</label>
    <input type="password" id="password_confirmation"   v-model="eventObj.password_confirmation">
        <button v-on:click="saveUser()">saveUser</button>
    </div>
</template>

<script>
    import axios from 'axios';
    import store from '../store';
    export default {
        name: 'subscription',
        data () {
            return {
                eventObj: {
                    name:'',
                    surname:'',
                    nickname:'',
                    dob:'',
                    password:'',
                    password_confirmation:''
                }
            }
        },
        methods: {
            isLogin() {
                return store.state.user.isLogin;
            },
            saveUser() {
                if(this.isLogin()) {
                    var aFinal = {};
                    for (var key in this.eventObj) {
                        if(this.eventObj[key] != "")  {
                            aFinal[key] = this.eventObj[key];
                        }
                    }

                    axios.put("http://localhost:3000/users/"+store.state.user.id, this.eventObj, {
                        headers: { Authorization: store.state.user.token}
                    }).then(function(response) {
                        console.log(response);
                    }).catch(function (error) {
                        console.log(error);
                    });
                }else{

                }
            }


        } ,
        created: function () {
            if(this.isLogin()) {
                let listAvailable = [ "name", "surname", "nickname", "dob"];
                let self = this
                axios.get("http://localhost:3000/users/"+store.state.user.id, {
                    headers: { Authorization: store.state.user.token}
                }).then(function(response) {
                    let userData = store.state.user
                    for (var key in  userData) {
                        if (response.data.user[0][key] && listAvailable.indexOf(key)>=0) {
                            userData[key] = response.data.user[0][key];
                        }
                    }
                    self.$data.eventObj = userData;
                    store.commit('updateUser', userData);
                }).catch(function (error) {
                    console.log(error);
                });

            }
        }

    }

</script>