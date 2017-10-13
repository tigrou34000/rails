<template>
    <div>
         <villedep @saveDep="saveDistance" v-bind:distanceSearch="distanceSearch" v-bind:distanceSearchList="distanceSearchList"    ></villedep>
         <villearr @saveArr="saveDistance" v-bind:distanceSearch="distanceSearch" v-bind:distanceSearchList="distanceSearchList"    ></villearr>

       De  {{depart.name}} vers  {{arrivee.name}} <br/>
        {{depart.lon}} {{depart.lat}}  ==>  {{arrivee.lon}} {{arrivee.lat}} <br/>
        Distance total en vol d'avion : {{distance}} KM


        <gmap :departure="depart"  :arrival="arrivee"></gmap>
    </div>
</template>



<script>


    import villedep from '../components/VilleDep.vue'
    import villearr from '../components/Villearr.vue'
    import gmap from '../components/Gmap.vue'

    export default {
        components: {
            villedep,
            villearr,
            gmap
        },
        data () {
            return {
                distanceSearch: 20,
                distanceSearchList: [ 20, 40, 60, 80, 100],
                depart :  {
                    lat : null ,
                    lon: null ,
                    name: null
                },
                arrivee :  {
                    lat : null,
                    lon: null,
                    name: null
                },
                distance : 0
            }
        },
        methods: {
            saveDistance (value, method) {
                var mytype = method == 1 ? this.depart : this.arrivee;
                mytype.lon = value[0];
                mytype.lat = value[1];
                mytype.name = value[2];

                if (this.depart.name !== null && this.arrivee.name !== null) {
                   this.distance =  this.getDistanceInKm();
                }

            },
            getDistanceInKm() {
                var depart, arrivee, lat1, lat2, lon1, lon2, dLat, dLon, a, c ,d = null;
                var R = 6371; // Radius of the earth in km

                depart = this.depart;
                arrivee = this.arrivee;

                lat1 = depart.lat;
                lon1 = depart.lon;
                lat2 = arrivee.lat;
                lon2 = arrivee.lon;

                 dLat = this.deg2rad(lat2 - lat1);  // deg2rad below
                 dLon = this.deg2rad(lon2 - lon1);
                 a =
                    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                    Math.cos(this.deg2rad(lat1)) * Math.cos(this.deg2rad(lat2)) *
                    Math.sin(dLon / 2) * Math.sin(dLon / 2)
                ;
                c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
                d = R * c; // Distance in km
                return d;
            },
            deg2rad(deg) {
                return deg * (Math.PI / 180)
            }
        }
    }



</script>