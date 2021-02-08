<template>
  <div id="app">
    
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      webs: "webs"
    }
  },
  mounted () {
    this.setWeb();
  },
  methods: {
    setWeb: function() {
      axios.get('/api/webs')
      .then(response => (
        this.webs = response.data
      ))
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
