<template>
    <div>
        <input id="villedep-id" type="text" v-model="villeDepId" />
        <input id="villedep-name" type="text" v-model="villeDepName" />
        lat : <input id="villedep-lat" type="text" v-model="villeDepLat">
        lon : <input id="villedep-lon" type="text" v-model="villeDepLon">
        <autocomplete
            url="http://localhost:3000/towns"
            anchor="title"
            label="writer"
            :on-select="getData"    id="villedep" :min="3"   :onShouldRenderChild="renderChild" placeholder="ville de depart" >
        </autocomplete>


        <select v-model="aerodromeDep">
            <option
                    v-for="item in listAerodromes"
                    v-bind:value="item"
                    v-bind:selected="aerodromeDep == item"
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
        props: ['coordonateDep'],
        data: () => ({
            villeDepId :0,
            villeDepName :'',
            villeDepLat : 0,
            villeDepLon : 0,
            listAerodromes: [],
            aerodromeDep: null
         }),
        components: { Autocomplete },
        watch: {
            aerodromeDep: function (val) {
                this.$emit("aerodromeDep", [val.coordonate_point[0],val.coordonate_point[1]]);

            }
        }
        ,
        created: function() {
            // We initially sync the internalValue with the value passed in by the parent
            this.aerodromeDep = this.coordonateDep;
        },

        methods: {
            getData(obj){
                this.villeDepId = obj.id
                this.villeDepLat =   obj.location.lat
                this.villeDepLon =  obj.location.lon
                this.villeDepName =  obj.name

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
                _this.listAerodromes = response.data;
               });
           },
            getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
                var R = 6371; // Radius of the earth in km
                var dLat = this.deg2rad(lat2-lat1);  // deg2rad below
                var dLon =this.deg2rad(lon2-lon1);
                var a =
                    Math.sin(dLat/2) * Math.sin(dLat/2) +
                    Math.cos(this.deg2rad(lat1)) * Math.cos(this.deg2rad(lat2)) *
                    Math.sin(dLon/2) * Math.sin(dLon/2)
                ;
                var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
                var d = R * c; // Distance in km
                return d;
            },
             deg2rad(deg) {
                return deg * (Math.PI/180)
            }


        }
    };

</script>

<link rel="stylesheet" href="vue2-autocomplete-js/dist/style/vue2-autocomplete.css">
