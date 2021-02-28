<template lang="pug">
  v-container.px-2(fluid)
    //- loading
    v-overlay(v-if="!isAuthenticated")
      v-progress-circular(indeterminate size="64")

    template(v-else)
      .title.mb-2 {{ typeDisplayName }}専用 希望提出ページ

      VotingInfo.mb-4(:item="authItem")

      adsbygoogle(v-if="isDev" ad-stot="1699494596")

      v-divider.my-4

      VotingForm(
        v-if="isGroup"
        :type="type"
        :items="roomParticipateUserItems"
        :hopeUidItems="hopeParticipateUserUidItems"
        :roomItem="roomItem"
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

      adsbygoogle(v-if="isDev" ad-stot="1699494596")
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { RoomInvitationType, Room, RoomGroup, RoomParticipateUser } from '~/modules/types/models'

@Component({
  layout: 'public',
  components: {
    VotingInfo: () => import('~/components/pages/rooms/voting/Info.vue'),
    VotingForm: () => import('~/components/pages/rooms/voting/Form.vue'),
  },
})
export default class RoomVotingPage extends Vue {
  get isDev(): boolean {
    return process.env.NODE_ENV !== 'development'
  }

  get typeDisplayName(): string {
    switch (this.type) {
      case 'group':
        return this.roomItem?.groupDisplayName || 'グループ'
      case 'participateUser':
        return ''
      default:
        return ''
    }
  }

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

  get authItem(): RoomGroup | RoomParticipateUser | null {
    return this.$store.state.invitation.authItem
  }

  get roomGroupItems(): RoomGroup[] | null {
    return this.$store.state.invitation.roomGroupItems
  }

  get roomParticipateUserItems(): RoomParticipateUser[] | null {
    return this.$store.state.invitation.roomParticipateUserItems
  }

  get hopeGroupUidItems(): string[] | null {
    return this.$store.state.invitation.authItem.hopeGroupUidItems || null
  }

  get hopeParticipateUserUidItems(): string[] | null {
    return this.$store.state.invitation.authItem.hopeParticipateUserUidItems || null
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
