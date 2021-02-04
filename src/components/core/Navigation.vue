<template lang="pug">
  v-navigation-drawer(v-model="drawer" app)
    v-sheet(color="grey lighten-4" class="pa-4")
      v-avatar.mb-4(color="grey darken-1" size="64")

      div {{ user.email }}

    v-divider

    v-list
      v-list-item(v-for="[icon, text] in links" :key="icon" link)
        v-list-item-icon
          v-icon {{ icon }}

        v-list-item-content
          v-list-item-title {{ text }}
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { User } from '~/modules/types/models'

@Component
export default class CoreNavigationComponent extends Vue {
  drawer = true

  get user(): User {
    return this.$store.state.auth.user
  }

  links = [
    {
      icon: 'mdi-inbox-arrow-down',
      text: 'Inbox',
    },
    {
      icon: 'mdi-inbox-arrow-down',
      text: 'Inbox',
    },
    {
      icon: 'mdi-inbox-arrow-down',
      text: 'Inbox',
    },
  ]
}
</script>
