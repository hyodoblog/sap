<template lang="pug">
  v-container(fluid)
    //- loading
    v-overlay(v-if="!isAuthenticated")
      v-progress-circular(indeterminate size="64")

    template(v-else)

</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { Room, RoomGroup, RoomParticipateUser } from '~/modules/types/models'

@Component({
  layout: 'public',
})
export default class RoomVotingPage extends Vue {
  get isAuthenticated(): boolean {
    return this.$store.getters['invitation/isAuthenticated']
  }

  get roomItem(): Room | null {
    return this.$store.state.invitation.roomItem
  }

  get roomGroupItems(): RoomGroup[] | null {
    return this.$store.state.invitation.roomGroupItems
  }

  get roomParticipateUserItems(): RoomParticipateUser[] | null {
    return this.$store.state.invitation.roomParticipateUserItems
  }
}
</script>
