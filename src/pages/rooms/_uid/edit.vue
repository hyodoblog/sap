<template lang="pug">
  v-container(style="max-width:1000px")
    BaseVComponent(:title="`「${name}」部屋の編集`" icon="mdi-monitor-dashboard")

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
  async asyncData({ app, error, route }) {
    try {
      const { uid } = route.params
      const item = await app.$fire.store.room.getItem(uid)
      if (item === null) throw Error
      return {
        roomUid: uid,
        iconPath: item.iconPath,
        name: item.name,
        description: item.description,
        startAt: item.startAt.toDate(),
      }
    } catch {
      error({
        statusCode: 404,
        message: 'ページが見つかりませんでした。',
      })
    }
  },
})
export default class RoomNewPage extends Vue {
  mounted() {
    if (this.iconPath) {
      this.getImgDataURLToUrl(this.iconPath)
    }
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

  // form var
  roomUid: string
  iconPath: string
  name: string
  description: string
  startAt: Date
  votingEndAt: Date
  browsingEndAt: Date
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
