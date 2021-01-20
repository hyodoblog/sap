<template lang="pug">
  v-app.index
      div#farst
        FarstView
      div#about
        About
      div#service
        Service
      div#history
        History
</template>

<script>
import { Component, Vue } from 'nuxt-property-decorator'
import FarstView from '~/components/top/FarstView.vue'
import About from '~/components/top/About.vue'
import History from '~/components/top/History.vue'
import Service from '~/components/top/Service.vue'

@Component({
  components: {
    FarstView,
    About,
    Service,
    History,
  },
})
export default class extends Vue {}
</script>

<style lang="scss" scoped>
.index {
  position: relative;
  background-color: white;

  @media (min-width: 0px) {
  }

  #about {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 1rem;
  }
  #service {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 1rem;
  }
  #history {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 1rem;
  }
}
</style>
