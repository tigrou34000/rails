<template>
    <div>
        <ul>
            <li v-for="(error, message) in errors_handling"> {{message}} : {{ error }}</li>
        </ul>
    </div>
</template>
<script>
    import { mapGetters } from 'vuex'
    export default {
        computed: mapGetters({
                    errors_handling: 'getErrors',
                })
    }



</script>

https://github.com/vuejs/vuex/blob/dev/examples/shopping-cart/components/ProductList.vue
https://stackoverflow.com/questions/45479097/vue-js-2-how-to-communicate-between-store-and-a-component/45480142#45480142