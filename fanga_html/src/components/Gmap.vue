<template>
    <div>
    <gmap-map
            :center="center"
            :zoom="5"
            style="width: 500px; height: 300px"
    >
        <gmap-marker
                :key="index"
                v-for="(m, index) in markers"
                :position="m.position"
                :clickable="false"
                :draggable="true"
                @click="center=m.position"
        ></gmap-marker>
    </gmap-map>
    {{departure}}
    </div>
</template>


<script>

import Vue from 'vue'
import * as VueGoogleMaps from 'vue2-google-maps'

export default {
    props: ["departure", "arrival"],
    data () {
        return {

            center: {lat: 48.86 , lng: 2.34445},
            markers: []
        }
    },
    watch: {
        '$props':{
            handler: function (val, oldVal) {
                this.markers = [];
                if (this.departure.lat !== null) {
                    this.markers.push({
                        position: {
                            lat: this.departure.lat,
                            lng: this.departure.lon
                        }
                    });
                }
                if (this.arrival.lat !== null) {
                    this.markers.push({
                        position: {
                            lat: this.arrival.lat,
                            lng: this.arrival.lon
                        }
                    });
                }
            },
            deep: true
        }


    }
}

Vue.use(VueGoogleMaps, {
    load: {
        key: process.env.GMAP_KEY,
        libraries: 'places'
    }

});

</script>