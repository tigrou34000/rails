<template>
    <div>
         <villedep v-model="coordonateDep" ></villedep>
         <villearr v-bind:coordonateArr="coordonateArr"></villearr>
        {{coordonateDep}}
        {{coordonateArr}}
        {{nbKm}}

    </div>
</template>
<script>
    import villedep from '../components/VilleDep.vue'

    import villearr from '../components/Villearr.vue'
    export default {
        components: {
            villedep,
            villearr
        },
        data () {
            return {
                coordonateDep : null,
                coordonateArr : null,
                nbKm : 0
            }
        }

    }


</script>