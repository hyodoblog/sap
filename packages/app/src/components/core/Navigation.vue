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

      //- logout
      v-list-item(link @click="signout")
        v-list-item-icon
          v-icon mdi-logout

        v-list-item-content
          v-list-item-title サインアウト
</template>

<script lang="ts">
import { Component, PropSync, Vue } from 'nuxt-property-decorator'
import { User } from '~/modules/types/models'

@Component
export default class CoreNavigationComponent extends Vue {
  @PropSync('drawerValue', { type: Boolean || null, default: null }) drawer!: boolean | null

  get user(): User {
    return this.$store.state.user.item
  }

  links = [
    {
      icon: 'mdi-monitor-dashboard',
      text: '部屋管理',
      link: this.$routes.front.rooms,
    },
  ]

  signout() {
    return this.$store
      .dispatch('user/signOut')
      .then(() => {
        this.$store.dispatch('snackbar/success', 'サインアウトしました')
        window.location.href = this.$routes.front.top
      })
      .catch(() => {
        this.$store.dispatch('snackbar/error', 'サインアウトに失敗しました')
      })
  }
}
</script>
