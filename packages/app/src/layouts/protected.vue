<template lang="pug">
  v-app#inspire
    CoreNavigation(:drawerValue.sync="navDrawer")
    CoreAppBar(:drawerValue.sync="navDrawer")

    v-main
      nuxt
    Snackbar
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  middleware: 'protected',
  components: {
    CoreAppBar: () => import('~/components/core/AppBar.vue'),
    CoreNavigation: () => import('~/components/core/Navigation.vue'),
    Snackbar: () => import('~/components/Snackbar.vue'),
  },
})
export default class ProtectedLayout extends Vue {
  navDrawer = null
}
</script>
