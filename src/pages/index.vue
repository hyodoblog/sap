<template lang="pug">
  v-main
    v-app-bar(dense fixed elevate-on-scroll height="80")
      v-container.py-0.px-0.px-sm-2.fill-height(fluid)
        nuxt-link.d-flex.align-center.text-decoration-none.mr-2(to="/dashboard/analytics")
          img(:src="require('@/assets/imgs/header-logo.png')" height="36")

        v-spacer

        template(v-if="isAuthenticated")
          v-btn(outlined large :to="$routes.front.rooms") 部屋一覧
        template(v-else)
          .d-none.d-md-block
            v-btn(text to="#about") SAPとは
            v-btn(text to="#service") 概要
            v-btn(text to="#history") 歴史
            v-btn(text class="mx-1" :to="$routes.front.signin") サインイン

          v-btn(outlined large :to="$routes.front.signup") サインアップ

    .index
      #farst
        FarstView
      #about.pb-10
        About.mx-auto
      #service.pb-10
        Service.mx-auto
      #history.pb-10
        History.mx-auto
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
export default class IndexPage extends Vue {
  get isAuthenticated(): boolean {
    return this.$store.getters['user/isAuthenticated']
  }
}
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
