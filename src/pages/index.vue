<template lang="pug">
  v-main
    v-app-bar(flat height="80")
      v-container.py-0.px-0.px-sm-2.fill-height(fluid)
        nuxt-link.d-flex.align-center.text-decoration-none.mr-2(to="/dashboard/analytics")
          img(:src="require('@/assets/imgs/header-logo.png')" height="36")

        v-spacer

        .d-none.d-md-block
          v-btn(text to="#about") SAPとは
          v-btn(text to="#service") 概要
          v-btn(text to="#history") 歴史
          v-btn(text class="mx-1" to="/auth/signin") サインイン

        v-btn(outlined large to="/auth/signup") サインアップ

    .index
      #farst
        FarstView
      #about
        About
      #service
        Service
      #history
        History
</template>

<script lang="ts">
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
export default class IndexPage extends Vue {}
</script>

<style lang="scss" scoped>
.index {
  background-color: white;

  #about {
    position: relative;
    padding: 1rem;
  }
  #service {
    text-align: center;
    position: relative;
    padding: 1rem;
  }
  #history {
    position: relative;
    padding: 1rem;
  }
}
</style>
