<template>
    <div id="wrapper">
        <nav class="navbar navbar-default">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <i class="glyphicon glyphicon-time"></i>
                    LiftAir
                </a>
                <ul class="nav navbar-nav">
                    <li><router-link to="/home">Home</router-link></li>
                    <li><router-link to="/user">login</router-link></li>
                    <li><router-link to="/myplan">my plan</router-link></li>
                </ul>
            </div>
        </nav>
        <div class="container">
                <Error></Error>
                <router-view></router-view>
        </div>
    </div>
</template>

<script>
    import Error from './components/Error.vue'
    export default {
        components: {Error}
    }
</script>