<template>
    <div>
    <label>email</label>
    <input type="text" id="email" v-model="eventObj.email" >
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
                    email:'',
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
            isLogin()
            {
                return store.user.state.isLogin;
            }

        } ,
        created: function () {
            if(this.isLogin()) {
                axios.post("http://localhost:3000/authenticate", {

                }

            }
        }

    }

</script>