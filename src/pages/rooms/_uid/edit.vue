<template lang="pug">
  v-container(style="max-width:1000px")
    template(v-if="roomUid")
      BaseVComponent(:title="`「${title}」部屋の編集`" icon="mdi-monitor-dashboard")

      RoomForm(
        submitText="編集する"
        :roomUidValue.sync="roomUid"
        :imgDataURLValue.sync="imgDataURL"
        :nameValue.sync="name"
        :descriptionValue.sync="description"
        :startAtValue.sync="startAt"
        :votingEndAtValue.sync="votingEndAt"
        :browsingEndAtValue.sync="browsingEndAt"
        :submitFunc="submit"
      )
  
    v-overlay(v-else)
      v-progress-circular(indeterminate size="64")
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
  async beforeCreate() {
    try {
      const { uid } = this.$route.params
      const item = await this.$fire.store.room.getItem(uid)
      if (item === null) throw Error
      this.setItem(item)
    } catch {
      this.$nuxt.error({
        statusCode: 404,
        message: 'ページが見つかりませんでした。',
      })
    }
  }

  setItem(item: Room) {
    this.title = item.name
    this.roomUid = item.uid as string
    this.iconPath = item.iconPath
    this.name = item.name
    this.description = item.description
    this.startAt = item.startAt.toDate()
    this.votingEndAt = item.votingEndAt.toDate()
    this.browsingEndAt = item.browsingEndAt.toDate()

    if (this.iconPath) this.getImgDataURLToUrl(this.iconPath)
  }

  async getImgDataURLToUrl(filePath: string) {
    const downloadUrl = await this.$fire.storage.getDownloadURL(filePath)
    const res = await this.$axios.get(downloadUrl, { responseType: 'blob' })
    const reader = new FileReader()
    reader.onload = (e: any) => {
      const imgDataURL = e.target.result as string
      this.imgDataURL = imgDataURL
    }
    reader.readAsDataURL(res.data)
  }

  title = ''

  // form var

  roomUid = ''
  iconPath = ''
  name = ''
  description = ''
  startAt = new Date()
  votingEndAt = new Date()
  browsingEndAt = new Date()
  imgDataURL = ''

  async submit(): Promise<void> {
    // ファイルパスを取得
    let iconPath = ''
    if (this.imgDataURL) {
      iconPath = `rooms/${this.roomUid}.jpg`
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
      await this.$api.back.updateRoom({ roomUid: this.roomUid, roomItem: item }, headers)
      this.$store.dispatch('snackbar/success', '部屋を編集しました。')
      this.$router.push(this.$routes.front.room(this.roomUid))
    } catch {
      if (iconPath) {
        this.$fire.storage.delete(iconPath)
      }
      this.$store.dispatch('snackbar/error', '部屋の編集に失敗しました。')
      throw Error
    }
  }
}
</script>
