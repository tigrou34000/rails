<template>
    <div>
        <autocomplete
            :url= "getTownUrl"
            anchor="title"
            label="writer"
            :on-select="getData" id="villearr"  :min="3"   :onShouldRenderChild="renderChild"  placeholder="ville d'arrivée">
        </autocomplete>

        <select v-model="distanceSearchSel" @change="onChangeKm()">
            <option v-for="distance in distanceSearchList"
                    v-bind:value="distance"
                    v-bind:selected="distanceSearch == distance">
                {{distance}} Km
            </option>
        </select>

        <select v-model="aerodromeArr">
            <option
                    v-for="item in listAerodromes"
                    v-bind:value="item"
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
        props: ['distanceSearch', 'distanceSearchList'],
        data: () => ({
            villeArr: null,
            listAerodromes: [],
            aerodromeArr: null,
            distanceSearchSel: 20,
            getTownUrl: process.env.RAILS_SERV_BASE + "/towns"
        }),
        components: { Autocomplete },
        watch: {
            aerodromeArr: function (val) {
                this.$emit("saveArr", [val.coordonate_point[0],val.coordonate_point[1], val.name_loc, val.id], 2);
            }
        } ,
        methods: {
            onChangeKm(){
                if(this.listAerodromes.length >0){
                    this.getAerodrome(this.villeArr.location.lon, this.villeArr.location.lat, this.distanceSearchSel )
                }
            },
            getData(obj){
                this.villeArr = obj;
                this.getAerodrome(obj.location.lon, obj.location.lat, this.distanceSearchSel )
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
<link rel="stylesheet" href="vue2-autocomplete-js/dist/style/vue2-autocomplete.css">
