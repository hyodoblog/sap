<template lang="pug">
  v-container(fluid)
    //- loading
    v-overlay(v-if="!isAuthenticated")
      v-progress-circular(indeterminate size="64")

    template(v-else)
      .title 投票ページ

      VotingForm(
        v-if="isGroup"
        :type="type"
        :items="roomGroupItems"
        :hopeUidItems="hopeParticipateUserUidItems"
      )
      VotingForm(
        v-else-if="isParticipateUser"
        :type="type"
        :items="roomParticipateUserItems"
        :hopeUidItems="hopeGroupUidItems"
      )
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

  get isGroup(): boolean {
    return this.type === 'group' && !!this.hopeParticipateUserUidItems
  }

  get isParticipateUser(): boolean {
    return this.type === 'participateUser' && !!this.hopeGroupUidItems
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

  get hopeGroupUidItems(): string[] | null {
    return this.$store.state.invitation.authItem.hopeGroupUidItems ?? null
  }

  get hopeParticipateUserUidItems(): string[] | null {
    return this.$store.state.invitation.authItem.hopeParticipateUserUidItems ?? null
  }
}
</script>
