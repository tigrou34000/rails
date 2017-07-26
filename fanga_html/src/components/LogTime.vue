
<template>
    <div class="form-horizontal">
        <div class="form-group">
            <div class="col-sm-6">
                <label>Date</label>
                <input
                        type="date"
                        class="form-control"
                        v-model="timeEntry.date"
                        placeholder="Date"
                />
            </div>
            <div class="col-sm-6">
                <label>Hours</label>
                <input
                        type="number"
                        class="form-control"
                        v-model="timeEntry.totalTime"
                        placeholder="Hours"
                />
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-12">
                <label>Comment</label>
                <input
                        type="text"
                        class="form-control"
                        v-model="timeEntry.comment"
                        placeholder="Comment"
                />
            </div>
        </div>
        <button class="btn btn-primary" @click="save()">Save</button>
        <button v-link="'/time-entry'" class="btn btn-danger">Cancel</button>
        <hr>
    </div>

</template>

<script>
    import store from '../store';

    export default {
        data () {
            return {
                // We default the user object on
                // the timeEntry to have some user details
                timeEntry: {
                    user: {
                        firstName: 'Eskie Sirius',
                        lastName: 'Maquilang',
                        email: 'eskiesiriusmaquilang@gmail.com',
                        image: 'https://s.gravatar.com/avatar/f8ffe384215d64694c4dfb263737ea39?s=80'
                    }
                }
            }
        },
        methods: {
            save () {
                let timeEntry = this.timeEntry

                // We dispatch the timeEntry so it can be pushed
                // onto the timeEntries array in the parent component
                if (Object.keys(timeEntry).length > 1)
                    store.commit('timeUpdate', timeEntry);

                this.timeEntry = {
                    user: {
                        firstName: 'Eskie Sirius',
                        lastName: 'Maquilang',
                        email: 'eskiesiriusmaquilang@gmail.com',
                        image: 'https://s.gravatar.com/avatar/f8ffe384215d64694c4dfb263737ea39?s=80'
                    }
                };
            }
        }
    }
</script>