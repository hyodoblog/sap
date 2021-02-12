<template lang="pug">
  v-card(v-if="isAuthenticated")
    v-app-bar(flat)
      v-avatar
        v-img(:src="$utils.url.getImgUrl(roomItem.iconPath)")
      v-toolbar-title.ml-2 「{{ roomItem.name }}」部屋

      v-spacer
      
      v-app-bar-nav-icon(@click="drawer = !drawer")
</template>

<script lang="ts">
import { Component, PropSync, Vue } from 'nuxt-property-decorator'
import { Room } from '~/modules/types/models'

@Component
export default class RoomDashboardVotingAppBarComponent extends Vue {
  @PropSync('drawerValue', { type: Boolean || null, default: null }) drawer: boolean | null

  get isAuthenticated(): boolean {
    return this.$store.getters['invitation/isAuthenticated']
  }

  get roomItem(): Room | null {
    return this.$store.state.invitation.roomItem
  }
}
</script>
