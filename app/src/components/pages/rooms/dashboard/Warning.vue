<template lang="pug">
  v-snackbar(v-model="isSnackbar" dark top right color="red" :timeout="-1")
    .subtitle-2.font-weight-bold
      | グループの最大参加人数が参加者の合計より少ないです。
      br
      | このままでは、設定した最大参加人数を超過したマッチングが行われます。
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { RoomGroup } from '~/modules/types/models'

@Component
export default class RoomDashboardWarningComponent extends Vue {
  get isSnackbar(): boolean {
    if (!!this.roomParticipateUserItems && this.roomGroupItems.length > 0) {
      let totalMaxNum = 0
      for (const item of this.roomGroupItems) {
        if (item.maxNum === null) break
        else totalMaxNum += item.maxNum
      }
      if (totalMaxNum < this.roomParticipateUserItems) return true
    }
    return false
  }

  get roomGroupItems(): RoomGroup[] {
    return this.$store.state.room.group.items
  }

  get roomParticipateUserItems(): number | undefined {
    return this.$store.state.room['participate-user'].items?.length
  }
}
</script>

<style lang="scss" scoped>
.close-btn {
  position: absolute;
  right: 0;
  top: 50%;
  transform: translate(-50%, 0);
}
</style>
