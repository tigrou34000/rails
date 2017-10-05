<template>
    <div>
        <input id="villearr-id" type="text" v-model="villeArrId" />
        <input id="villearr-name" type="text" v-model="villeArrName" />
        <input id="villearr-lat" type="text" v-model="villeArrLat">
        <input id="villearr-lon" type="text" v-model="villeArrLon">
        <autocomplete
                url="http://localhost:3000/towns"
                anchor="title"
                label="writer"
                :on-select="getData"  id="villearr"  :min="3"   :onShouldRenderChild="renderChild"  placeholder="ville d'arrivée">
        </autocomplete>
    </div>
</template>

<script>
    import Autocomplete from 'vue2-autocomplete-js';
    export default {
        data: () => ({
            villeArrId :0,
            villeArrName :'',
            villeArrLat : 0,
            villeArrLon : 0,
        }),
        components: { Autocomplete },
        methods: {
            getData(obj){
                this.villeArrId = obj.id
                this.villeArrlat =   obj.location.lat
                this.villeArrLon =  obj.location.lon
                this.villeArrName =  obj.name

            },
            renderChild(data) {
                return `
                  <span>${data.name} ${data.cpt}</span>
                `;
            },
        }
    };

</script>

<link rel="stylesheet" href="vue2-autocomplete-js/dist/style/vue2-autocomplete.css">
