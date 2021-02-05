<template lang="pug">
  v-container(style="max-width:1000px")
    BaseVComponent(title="SAP作成" icon="mdi-monitor-dashboard")

    RoomsForm(
      submitText="作成する"
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
const RoomsForm = () => import('~/components/page/sap-apps/Form.vue')

@Component({
  layout: 'protected',
  components: { BaseVComponent, RoomsForm },
})
export default class RoomNewPage extends Vue {
  // form var
  name = ''
  description = ''
  startAt = this.$fire.store.getNowAtToDate()
  votingEndAt = this.$fire.store.getNowAtToDate()
  browsingEndAt = this.$fire.store.getNowAtToDate()
  imgDataURL = ''

  async submit(): Promise<void> {
    // ファイルパスを取得
    const sapAppUid = this.$fire.store.sapApp.getUid()
    let iconPath = ''
    if (this.imgDataURL) {
      iconPath = `menus/${sapAppUid}.jpg`
    }

    try {
      // 画像をアップロード
      if (iconPath) {
        await this.$fire.storage.uploadToDataURL(iconPath, this.imgDataURL)
      }

      // firestoreに保存
      const itme: Room = {
        userUid: this.$store.state.auth.userUid,
        iconPath,
        name: this.name,
        description: this.description,
        startAt: this.$fire.store.convertTimestamp(this.startAt),
        votingEndAt: this.$fire.store.convertTimestamp(this.votingEndAt),
        browsingEndAt: this.$fire.store.convertTimestamp(this.browsingEndAt),
      }
      const headers = await this.$fire.auth.getAuthHeaders()
      await this.$api.back.createRoom({ sapAppUid, sapAppItem: itme }, headers)
    } catch {
      if (iconPath) {
        this.$fire.storage.delete(iconPath)
      }
      throw Error
    }
  }
}
</script>
