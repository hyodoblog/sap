<template lang="pug">
  v-container(fluid)
    //- loading
    v-overlay(v-if="!isAuthenticated")
      v-progress-circular(indeterminate size="64")

    template(v-else)
      .title 投票ページ

      VotingForm(v-if="type === 'group'" :items="roomGroupItems")
      VotingForm(v-else-if="type === 'participateUser'" :items="roomParticipateUserItems")
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { RoomInvitationType, Room, RoomGroup, RoomParticipateUser } from '~/modules/types/models'

@Component({
  layout: 'public',
  components: {
    VotingForm: () => import('~/components/pages/rooms/voting/Form.vue'),
  },
})
export default class RoomVotingPage extends Vue {
  get isAuthenticated(): boolean {
    return this.$store.getters['invitation/isAuthenticated']
  }

  get type(): RoomInvitationType | null {
    return this.$store.state.invitation.type
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
