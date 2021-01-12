<template>
  <div class="top">
    <img src="top.PNG" />
    <about />
    <p></p>
    <service />
    <p></p>
    <history />
  </div>
</template>

<script>
import About from '~/components/top/About.vue'
import History from '~/components/top/History.vue'
import Service from '~/components/top/Service.vue'
export default {
  // layout: 'auth',
  components: {
    About,
    Service,
    History,
  },
}
</script>

<style>
.top {
  background-color: white;
}
</style>
