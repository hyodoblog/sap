<template lang="pug">
  v-container(fluid)
    template(v-if="room && (roomGroupItem || roomParticipateUserItem)")

    v-overlay(v-else)
      v-progress-circular(indeterminate size="64")
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { Room, RoomGroup, RoomParticipateUser } from '~/modules/types/models'

@Component({
  layout: 'protected',
})
export default class RoomVotingPage extends Vue {
  // 招待メールの処理
  async beforeCreate() {
    try {
      const { roomInvitationType, roomUid, loginToken, roomGroupUid, roomParticipateUserUid } = this.$route.query
      if (typeof roomInvitationType === 'string' && typeof roomUid === 'string' && typeof loginToken === 'string') {
        if (roomInvitationType === 'group' && typeof roomGroupUid === 'string') {
          const room = await this.$fire.store.room.getItem(roomUid as string)
          const roomGroupItem = await this.$fire.store.roomGroup.getItemToLoginToken(roomUid, roomGroupUid, loginToken)
          this.room = room
          this.roomGroupItem = roomGroupItem
        } else if (roomInvitationType === 'participateUser' && typeof roomParticipateUserUid === 'string') {
          const room = await this.$fire.store.room.getItem(roomUid)
          const roomParticipateUserItem = await this.$fire.store.roomParticipateUser.getItemToLoginToken(
            roomUid,
            roomParticipateUserUid,
            loginToken
          )
          this.room = room
          this.roomParticipateUserItem = roomParticipateUserItem
        } else throw Error
      }
    } catch {
      this.$nuxt.error({
        statusCode: 404,
        message: 'ページが見つかりませんでした。',
      })
    }
  }

  room: Room | null = null
  roomGroupItem: RoomGroup | null = null
  roomParticipateUserItem: RoomParticipateUser | null = null
}
</script>
