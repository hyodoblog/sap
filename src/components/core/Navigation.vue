<template lang="pug">
  v-navigation-drawer(v-model="drawer" app)
    v-sheet(color="grey lighten-4" class="pa-4")
      v-avatar.mb-4(color="grey darken-1" size="64")

      div {{ user.email }}

    v-divider

    v-list
      v-list-item(v-for="item in links" :key="item.text" link :to="item.link")
        v-list-item-icon
          v-icon {{ item.icon }}

        v-list-item-content
          v-list-item-title {{ item.text }}
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { User } from '~/modules/types/models'

@Component
export default class CoreNavigationComponent extends Vue {
  get user(): User {
    return this.$store.state.auth.user
  }

  drawer = null
  links = [
    {
      icon: 'mdi-monitor-dashboard',
      text: '部屋管理',
      link: this.$routes.front.rooms,
    },
  ]
}
</script>
