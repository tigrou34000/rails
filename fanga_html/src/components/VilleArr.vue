<template>
    <div>
        <input id="villearr-id" type="text" v-model="villeArrId" />
        <input id="villearr-name" type="text" v-model="villeArrName" />
        lat :<input id="villearr-lat" type="text" v-model="villeArrLat">
        lon :<input id="villearr-lon" type="text" v-model="villeArrLon">
        <autocomplete
                url="http://localhost:3000/towns"
                anchor="title"
                label="writer"
                :on-select="getData"  id="villearr"  :min="3"   :onShouldRenderChild="renderChild"  placeholder="ville d'arrivée">
        </autocomplete>
        <select v-model="aerodromeArr">
            <option
                    v-for="item in listAerodromes"
                    v-bind:value="item.name_loc"
                    v-bind:selected="aerodromeArr == item"
            >
                {{ item.name_loc }} ( {{Math.round(item.distance * 100) / 100 }} km )
            </option>
        </select>
    </div>
</template>

<script>
    import axios from 'axios';
    import Autocomplete from 'vue2-autocomplete-js';
    export default {
        data: () => ({
            villeArrId :0,
            villeArrName :'',
            villeArrLat : 0,
            villeArrLon : 0,
            listAerodromes: [],
            aerodromeArr: 0
        }),
        components: { Autocomplete },
        methods: {
            getData(obj){
                this.villeArrId = obj.id
                this.villeArrlat =   obj.location.lat
                this.villeArrLon =  obj.location.lon
                this.villeArrName =  obj.name
                this.getAerodrome(obj.location.lon, obj.location.lat, 50 )
            },
            renderChild(data) {
                return `
                  <span>${data.name} ${data.cpt}</span>
                `;
            },
            getAerodrome(lon, lat, ray) {
                var _this = this;

                axios.get("http://localhost:3000/aerodromes?lon="+lon+"&lat="+lat+"&ray="+ray, {}).then(function(response) {
                    console.log(response.data);
                    _this.listAerodromes = response.data;
                });
            }
        }

    };

</script>

<link rel="stylesheet" href="vue2-autocomplete-js/dist/style/vue2-autocomplete.css">
