<template>
    <div id="wrapper">
        <nav class="navbar navbar-default">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <i class="glyphicon glyphicon-time"></i>
                    Vue Time Tracker
                </a>
                <ul class="nav navbar-nav">
                    <li><router-link to="/home">Home</router-link></li>
                    <li><router-link to="/time-entry">Time Entries</router-link></li>
                </ul>
            </div>
            <login_div></login_div>
        </nav>
        <div class="container">
            <div class="col-sm-3">
                <sidebar :time="totalTime"></sidebar>
            </div>
            <div class="col-sm-9">
                <router-view></router-view>
            </div>
        </div>
    </div>
</template>

<script>
    import Sidebar from './components/Sidebar.vue'
    import Logindiv from './components/LoginDiv.vue'
    import store from './store';
    export default {
        components: {
            'sidebar': Sidebar ,
            'login_div': Logindiv
        },
        computed: {
            totalTime(){
                return store.state.totalTime;
            }
        }
    }
</script>