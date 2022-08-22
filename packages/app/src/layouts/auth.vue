<template lang="pug">
  v-app
    .d-flex.text-center.flex-column.flex-md-row.flex-grow-1
      v-sheet.layout-side.mx-auto.mx-md-1.d-none.d-md-flex.flex-md-column.justify-space-between.px-2
        .mt-3.mt-md-10.pa-2
          .headline.font-weight-bold.primary--text 研究室マッチングシステム
          .title.my-2 ようこそ、
          v-btn.my-4(:to="$routes.front.top" elevation="0" color="warning") トップページ
        img.w-full(src="/images/illustrations/signin-illustration.svg")

      .pa-2.pa-md-4.flex-grow-1.align-center.justify-center.d-flex.flex-column
        .layout-content.ma-auto.w-full
          nuxt
        .overline.mt-4
          | Build by 
          a(href="https://twitter.com/hyodoblog" target="_blank") Yusei Hyodo
    Snackbar
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
const Snackbar = () => import('~/components/Snackbar.vue')

@Component({
  middleware: 'auth',
  components: { Snackbar },
})
export default class AuthLayout extends Vue {}
</script>

<style scoped>
.layout-side {
  width: 420px;
}

.layout-content {
  max-width: 480px;
}
</style>
