<template>
    <div>

    <div class="success">
        {{message}}
    </div>
    <label>name</label>
    <input type="text" id="name"   placeholder="Type your full name..."  v-model="eventObj.name">
    <label>surname</label>
    <input type="text" id="surname"   placeholder="Type your surname..."  v-model="eventObj.surname">
    <label>nickname</label>
    <input type="text" id="nickname" placeholder="Type your nickname..."  v-model="eventObj.nickname">
    <label>Date of birthday</label>
    <input type="text" id="dob" placeholder="Type your date of birthday" v-model="eventObj.dob">

    <label>password</label>
    <input type="password" id="password" placeholder="Type your password"  v-model="eventObj.password">
    <label>password confirmation</label>
    <input type="password" id="password_confirmation" placeholder="Type your password confirmation"  v-model="eventObj.password_confirmation">
        <button v-on:click="saveUser()">saveUser</button>
    </div>
</template>

<script>
    import axios from 'axios';
    import { mapGetters, mapActions } from 'vuex'
    import store from '../store/index'
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
                },
                message: ''

            }
        },
        computed: {
                ...mapGetters({
                isLogin : "isLogin",
                getUser : "getUser"
            })
        },
        methods: {
            saveUser() {
                 let self = this
                if(this.isLogin) {
                    var user = this.getUser
                    var aFinal = {};
                    for (var key in this.eventObj) {
                        if(this.eventObj[key] != "" &&  this.eventObj[key]!== null)  {
                            aFinal[key] = this.eventObj[key];
                        }
                    }
                    axios.put(process.env.RAILS_SERV_BASE+"/users/"+user.id, aFinal, {
                        headers: { Authorization: user.token}
                    }).then(function(response) {
                        store.dispatch('updateUser', aFinal);
                        self.message = 'Update done'
                    }).catch(function (error) {
                        for(var err in error.response.data.error) {
                            var a = {}
                            a[err] = error.response.data.error[err][0]
                            store.dispatch('setErrors', a);
                        }
                    });
                }else{

                }
            }


        } ,
        created: function () {
            if(this.isLogin) {
                let listAvailable = [ "name", "surname", "nickname", "dob"];
                let self = this
                var user = this.getUser

                axios.get(process.env.RAILS_SERV_BASE+"/users/"+user.id, {
                    headers: { Authorization: user.token}
                }).then(function(response) {
                    var aContent = {}
                    for (var key in  response.data.user[0]) {
                        if (response.data.user[0][key] !="" && listAvailable.indexOf(key)>=0) {
                            self.$data.eventObj[key] = response.data.user[0][key];
                            aContent[key] = response.data.user[0][key];
                        }
                    }
                    store.dispatch('updateUser', aContent);
                }).catch(function (error) {
                    for(var err in error.response.data.error) {
                        var a = {}
                        a[err] = error.response.data.error[err][0]
                        store.dispatch('setErrors', a);
                    }
                });

            }
        }

    }

</script>