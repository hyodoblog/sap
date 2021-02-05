<template lang="pug">
  v-container(style="max-width:1000px")
    BaseVComponent(title="部屋作成" icon="mdi-monitor-dashboard")

    client-only
      RoomForm(
        submitText="作成する"
        :roomUidValue.sync="roomUid"
        :imgDataURLValue.sync="imgDataURL"
        :nameValue.sync="name"
        :descriptionValue.sync="description"
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
  startAt = this.$fire.store.getNowAtToDate()
  votingEndAt = this.$fire.store.getNowAtToDate()
  browsingEndAt = this.$fire.store.getNowAtToDate()
  imgDataURL = ''

  async submit(): Promise<void> {
    // ファイルパスを取得
    const roomUid = this.$fire.store.room.getUid()
    let iconPath = ''
    if (this.imgDataURL) {
      iconPath = `rooms/${roomUid}.jpg`
    }

    try {
      // 画像をアップロード
      if (iconPath) {
        await this.$fire.storage.uploadToDataURL(iconPath, this.imgDataURL)
      }

      // firestoreに保存
      const item: Room = {
        userUid: this.$store.state.auth.userUid,
        iconPath,
        name: this.name,
        description: this.description,
        startAt: this.$fire.store.convertTimestamp(this.startAt),
        votingEndAt: this.$fire.store.convertTimestamp(this.votingEndAt),
        browsingEndAt: this.$fire.store.convertTimestamp(this.browsingEndAt),
      }
      const headers = await this.$fire.auth.getAuthHeaders()
      await this.$api.back.createRoom({ roomUid, roomItem: item }, headers)
      this.$store.dispatch('snackbar/success', '部屋を作成しました。')
      this.$store.dispatch('room/init')
    } catch {
      if (iconPath) {
        this.$fire.storage.delete(iconPath)
      }
      this.$store.dispatch('snackbar/error', '部屋の作成に失敗しました。')
      throw Error
    }
  }
}
</script>
