<template lang="pug">
  v-app#inspire
    v-system-bar(app)
      v-spacer
      v-icon mdi-square
      v-icon mdi-circle
      v-icon mdi-triangle

    CoreNavigation

    v-main
      nuxt
    Snackbar
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
const CoreNavigation = () => import('~/components/core/Navigation.vue')
const Snackbar = () => import('~/components/Snackbar.vue')

@Component({
  middleware: 'protected',
  components: { CoreNavigation, Snackbar },
})
export default class ProtectedLayout extends Vue {
  cards = ['Today', 'Yesterday']
  drawer = null
  links = [
    ['mdi-inbox-arrow-down', 'Inbox'],
    ['mdi-send', 'Send'],
    ['mdi-delete', 'Trash'],
    ['mdi-alert-octagon', 'Spam'],
  ]
}
</script>
