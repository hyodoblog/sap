<template lang="pug">
  v-navigation-drawer(v-model="drawer" app)
    v-sheet.pa-4(color="primary")
      v-avatar.mb-4(color="grey darken-1" size="64")
      div {{ email }}
    
    v-divider
    v-list
      v-list-item(v-for="(item, i) in links" :key="i" link)
        v-list-item-icon
          v-icon {{ item.icon }}
        v-list-item-content
          v-list-item-title {{ item.text }}
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component
export default class CoreNavigationComponent extends Vue {
  drawer = true

  email = 'john@vuetifyjs.com'
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
