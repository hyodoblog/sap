<template lang="pug">
  v-container(style="max-width:1000px")
    BaseVComponent(title="部屋作成" icon="mdi-monitor-dashboard")

    client-only
      RoomForm(
        submitText="作成する"
        :roomUidValue.sync="roomUid"
        :nameValue.sync="name"
        :descriptionValue.sync="description"
        :isPublicValue.sync="isPublic"
        :groupDisplayNameValue.sync="groupDisplayName"
        :groupIsEditValue.sync="groupIsEdit"
        :groupHopeMaxNumValue.sync="groupHopeMaxNum"
        :participateUserDisplayNameValue.sync="participateUserDisplayName"
        :participateUserIsEditValue.sync="participateUserIsEdit"
        :participateUserHopeMaxNumValue.sync="participateUserHopeMaxNum"
        :startAtValue.sync="startAt"
        :votingEndAtValue.sync="votingEndAt"
        :browsingEndAtValue.sync="browsingEndAt"
        :submitFunc="submit"
      )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { Room } from '~/modules/types/models'
const BaseVComponent = () => import('~/components/base/BaseVComponent.vue')
const RoomForm = () => import('~/components/pages/rooms/Form.vue')

@Component({
  layout: 'protected',
  components: { BaseVComponent, RoomForm },
})
export default class RoomNewPage extends Vue {
  // form var
  roomUid = ''
  name = ''
  description = ''
  isPublic = false

  // group
  groupDisplayName: string | null = null
  groupIsEdit = false
  groupHopeMaxNum: number | null = null

  // participate user
  participateUserDisplayName: string | null = null
  participateUserIsEdit = false
  participateUserHopeMaxNum: number | null = null

  startAt = this.$fire.store.getNowAtToDate()
  votingEndAt = this.$fire.store.getNowAtToDate()
  browsingEndAt = this.$fire.store.getNowAtToDate()

  async submit(): Promise<void> {
    // ファイルパスを取得
    const roomUid = this.$fire.store.room.getUid()

    try {
      // firestoreに保存
      const item: Room = {
        userUid: this.$store.state.user.uid,
        name: this.name,
        description: this.description,
        isPublic: this.isPublic,
        groupDisplayName: this.groupDisplayName,
        groupIsEdit: this.groupIsEdit,
        groupHopeMaxNum: this.groupHopeMaxNum,
        participateUserDisplayName: this.participateUserDisplayName,
        participateUserIsEdit: this.participateUserIsEdit,
        participateUserHopeMaxNum: this.participateUserHopeMaxNum,
        startAt: this.$fire.store.convertTimestamp(this.startAt),
        votingEndAt: this.$fire.store.convertTimestamp(this.votingEndAt),
        browsingEndAt: this.$fire.store.convertTimestamp(this.browsingEndAt),
      }
      const headers = await this.$fire.auth.getAuthHeaders()
      await this.$api.back.createRoom({ roomUid, roomItem: item }, headers)
      this.$store.dispatch('snackbar/success', '部屋を作成しました。')
      this.$router.push(this.$routes.front.rooms)
    } catch {
      this.$store.dispatch('snackbar/error', '部屋の作成に失敗しました。')
      throw Error
    }
  }
}
</script>
