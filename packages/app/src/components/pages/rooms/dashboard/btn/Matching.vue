<template lang="pug">
  v-btn(
    color="primary"
    elevation="0"
    :disabled="loading"
    :loading="loading"
    @click="matching"
  ) マッチング手動実行
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'nuxt-property-decorator'

@Component
export default class RoomsDashboardBtnMatchingComponent extends Vue {
  @Prop({ type: String, required: true }) uid!: string

  loading = false

  matching() {
    if (this.uid) {
      this.loading = true
      return this.$fire.functions
        .matching(this.uid as string)
        .then(() => this.$store.dispatch('snackbar/success', 'マッチング処理が完了しました'))
        .catch(() => this.$store.dispatch('snackbar/error', 'マッチング処理に失敗しました'))
        .finally(() => (this.loading = false))
    }
  }
}
</script>
