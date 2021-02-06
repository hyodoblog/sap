<template lang="pug">
  v-dialog(
    v-model="dialog"
    max-width="350"
    persistent
  )
    template(v-slot:activator="{ on }")
      v-btn(
        v-on="on"
        :disabled="groupNum + participateUserNum === 0"
        color="info"
      ) 登録したメンバーへ招待メールを送る

    v-card.pa-4
      v-btn.my-2(
        block
        large
        color="info"
        :disabled="isDisabled || groupNum === 0"
        :loading="isGroupAllLoaidng"
        @click="groupAllSend"
      ) グループ全員に送る ({{ groupNum }}名)
      v-btn.my-2(
        block
        large
        color="info"
        :disabled="isDisabled || participateUserNum === 0"
        :loading="isParticipateUserAllLoaidng"
        @click="participateUserAllSend"
      ) 参加者全員に送る ({{ participateUserNum }}名)
      v-btn.my-2(
        block
        large
        color="info"
        :disabled="isDisabled"
        :loading="isAllLoading"
        @click="allSend"
      ) 全員に送る ({{ groupNum + participateUserNum }}名)
      v-btn.my-2(
        block
        outlined
        large
        :disabled="isDisabled"
        @click="dialog = false"
      ) 閉じる
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component
export default class RoomsDashboardInvitation extends Vue {
  dialog = false

  get groupNum(): number {
    return this.$store.getters['room/group/getIsEmailNum']
  }

  get participateUserNum(): number {
    return this.$store.getters['room/participate-user/getIsEmailNum']
  }

  // form var

  isDisabled = false
  isGroupAllLoaidng = false
  isParticipateUserAllLoaidng = false
  isAllLoading = false

  // form submit func

  async groupAllSend() {
    try {
      this.isDisabled = this.isGroupAllLoaidng = true
      const roomUid = this.$route.params.uid
      const headers = await this.$fire.auth.getAuthHeaders()
      await this.$api.back.groupAllInvitation({ roomUid }, headers)
      this.$store.dispatch('snackbar/success', '招待メールを送信しました。')
      this.dialog = false
    } catch {
      this.$store.dispatch('snackbar/error', '招待メールの送信に失敗しました。')
    } finally {
      this.isDisabled = this.isGroupAllLoaidng = false
    }
  }

  async participateUserAllSend() {
    try {
      this.isDisabled = this.isParticipateUserAllLoaidng = true
      const roomUid = this.$route.params.uid
      const headers = await this.$fire.auth.getAuthHeaders()
      await this.$api.back.participateUserAllInvitation({ roomUid }, headers)
      this.$store.dispatch('snackbar/success', '招待メールを送信しました。')
      this.dialog = false
    } catch {
      this.$store.dispatch('snackbar/error', '招待メールの送信に失敗しました。')
    } finally {
      this.isDisabled = this.isParticipateUserAllLoaidng = false
    }
  }

  async allSend() {
    try {
      this.isDisabled = this.isAllLoading = true
      const roomUid = this.$route.params.uid
      const headers = await this.$fire.auth.getAuthHeaders()
      await this.$api.back.allInvitation({ roomUid }, headers)
      this.$store.dispatch('snackbar/success', '招待メールを送信しました。')
      this.dialog = false
    } catch {
      this.$store.dispatch('snackbar/error', '招待メールの送信に失敗しました。')
    } finally {
      this.isDisabled = this.isAllLoading = false
    }
  }
}
</script>
