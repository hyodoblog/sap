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
        :items="roomParticipateUserItems"
        :hopeUidItems="hopeParticipateUserUidItems"
        :maxNum="roomItem.groupHopeMaxNum"
        :submitFunc="groupHopeSubmit"
      )
      VotingForm(
        v-else-if="isParticipateUser"
        :type="type"
        :items="roomGroupItems"
        :hopeUidItems="hopeGroupUidItems"
        :maxNum="roomItem.participateUserHopeMaxNum"
        :submitFunc="participateUserHopeSubmit"
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
  get roomUid(): string {
    return this.$route.params.uid
  }

  get isAuthenticated(): boolean {
    return this.$store.getters['invitation/isAuthenticated']
  }

  get isGroup(): boolean {
    return this.type === 'group' && this.hopeParticipateUserUidItems !== null
  }

  get isParticipateUser(): boolean {
    return this.type === 'participateUser' && this.hopeGroupUidItems !== null
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

  groupHopeSubmit(hopeItems: RoomGroup[]) {
    const hopeUidItems = hopeItems.map((item) => item.uid)
    return this.$fire.store.roomGroup
      .updateItem(this.roomUid, this.$store.state.invitation.authItem.uid, {
        hopeParticipateUserUidItems:
          this.roomItem?.groupHopeMaxNum === null
            ? hopeUidItems
            : hopeUidItems.slice(0, this.roomItem?.groupHopeMaxNum),
      } as RoomGroup)
      .then(() => this.$store.dispatch('invitation/resetAuthItem', 'group' as RoomInvitationType))
  }

  participateUserHopeSubmit(hopeItems: RoomParticipateUser[]) {
    const hopeUidItems = hopeItems.map((item) => item.uid)
    return this.$fire.store.roomParticipateUser
      .updateItem(this.roomUid, this.$store.state.invitation.authItem.uid, {
        hopeGroupUidItems:
          this.roomItem?.participateUserHopeMaxNum === null
            ? hopeUidItems
            : hopeUidItems.slice(0, this.roomItem?.participateUserHopeMaxNum),
      } as RoomParticipateUser)
      .then(() => this.$store.dispatch('invitation/resetAuthItem', 'participateUser' as RoomInvitationType))
  }
}
</script>
