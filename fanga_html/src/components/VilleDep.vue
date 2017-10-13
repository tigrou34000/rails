<template>
    <div>
        <autocomplete
            :url= "getTownUrl"
            anchor="title"
            label="writer"
            :on-select="getData" id="villeDep" :min="3"  :onShouldRenderChild="renderChild" placeholder="ville de depart" :classes="{ input: 'form-control', wrapper: 'input-wrapper'}"  >
        </autocomplete>
        <select v-model="distanceSearchSel" @change="onChangeKm()">
            <option v-for="distance in distanceSearchList"
                    v-bind:value="distance"
                    v-bind:selected="distanceSearch == distance">
               {{distance}} Km
            </option>
        </select>

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
        props: ['distanceSearch', 'distanceSearchList'],

        data: () => ({
            villeDep: null,
            listAerodromes: [],
            aerodromeDep: null,
            distanceSearchSel: 20,
            getTownUrl: process.env.RAILS_SERV_BASE + "/towns"
         }),
        components: { Autocomplete },
        watch: {
            aerodromeDep: function (val) {
                this.$emit("saveDep", [val.coordonate_point[0],val.coordonate_point[1], val.name_loc], 1);
            }
        },
        methods: {
            onChangeKm(){
                if(this.listAerodromes.length >0){
                    this.getAerodrome(this.villeDep.location.lon, this.villeDep.location.lat, this.distanceSearchSel )
                }

            },
            getData(obj){
                this.villeDep = obj;
                this.getAerodrome(obj.location.lon, obj.location.lat, this.distanceSearchSel )
                this.preContent = obj.name
            },
            renderChild(data) {
                return `
                  <span>${data.name} ${data.cpt}</span>
                `;
           },
           getAerodrome(lon, lat, ray) {
               var _this = this;
               axios.get(process.env.RAILS_SERV_BASE+"/aerodromes?lon="+lon+"&lat="+lat+"&ray="+ray, {}).then(function(response) {
                _this.listAerodromes = response.data;
               });
           }


        }
    };
</script>
<link rel="stylesheet" href="vue2-autocomplete-js/dist/style/vue2-autocomplete.css" />
