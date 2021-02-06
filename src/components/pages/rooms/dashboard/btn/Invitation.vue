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
        :loading="isDisabled"
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

  groupAllSend() {}

  participateUserAllSend() {}

  allSend() {}
}
</script>
