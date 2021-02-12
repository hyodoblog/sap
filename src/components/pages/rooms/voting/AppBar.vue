<template lang="pug">
  v-card(v-if="isAuthenticated")
    v-toolbar(flat)
      v-avatar
        v-img(:src="$utils.url.getImgUrl(roomItem.iconPath)")
      v-toolbar-title.ml-2 「{{ roomItem.name }}」部屋

      v-spacer
      
      v-app-bar-nav-icon
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { Room } from '~/modules/types/models'

@Component
export default class RoomDashboardVotingAppBarComponent extends Vue {
  get isAuthenticated(): boolean {
    return this.$store.getters['invitation/isAuthenticated']
  }

  get roomItem(): Room | null {
    return this.$store.state.invitation.roomItem
  }
}
</script>
