<template>
  <div>
    <img src="top.PNG" />
    <about />
    <service />
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
