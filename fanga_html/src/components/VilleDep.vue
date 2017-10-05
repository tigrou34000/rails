<template>
    <div>
        <input id="villedep-id" type="text" v-model="villeDepId" />
        <input id="villedep-name" type="text" v-model="villeDepName" />
        <input id="villedep-lat" type="text" v-model="villeDepLat">
        <input id="villedep-lon" type="text" v-model="villeDepLon">
        <autocomplete
            url="http://localhost:3000/towns"
            anchor="title"
            label="writer"
            :on-select="getData"    id="villedep" :min="3"   :onShouldRenderChild="renderChild" placeholder="ville de depart" v-model="searchVille" >
        </autocomplete>
    </div>

</template>

<script>
    import Autocomplete from 'vue2-autocomplete-js';
    export default {
        data: () => ({
            villeDepId :0,
            villeDepName :'',
            villeDepLat : 0,
            villeDepLon : 0,
            searchVille: ''
         }),
        components: { Autocomplete },
        methods: {
            getData(obj){
                this.villeDepId = obj.id
                this.villeDepLat =   obj.location.lat
                this.villeDepLon =  obj.location.lon
                this.villeDepName =  obj.name
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
