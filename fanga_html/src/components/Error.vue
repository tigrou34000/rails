<template>
    <div v-if="errors && errors.length">
        <ul>
            <li v-for="error in errors">{{ error }}</li>
        </ul>
    </div>
</template>
<script>
    module.exports = {
        props: ['errors']
    };
</script>