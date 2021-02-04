<template lang="pug">
  v-app#inspire
    v-system-bar(app)
      v-spacer
      v-icon mdi-square
      v-icon mdi-circle
      v-icon mdi-triangle

    v-navigation-drawer(v-model="drawer" app)
      v-sheet(color="grey lighten-4" class="pa-4")
        v-avatar.mb-4(color="grey darken-1" size="64")

        div john@vuetifyjs.com

      v-divider

      v-list
        v-list-item(v-for="[icon, text] in links" :key="icon" link)
          v-list-item-icon
            v-icon {{ icon }}

          v-list-item-content
            v-list-item-title {{ text }}

    v-main
      nuxt
    Snackbar
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import Snackbar from '~/components/Snackbar.vue'

@Component({
  middleware: 'protected',
  components: { Snackbar },
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
