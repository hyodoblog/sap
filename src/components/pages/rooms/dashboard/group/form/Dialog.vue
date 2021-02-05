<template lang="pug">
  v-dialog(
    v-model="dialog"
    max-width="600"
    persistent
  )
    v-card
      .d-flex
        v-col(cols="5")
          .subtitle-1
            | 名前
            v-chip.ml-1(x-small) 必須
        v-col(cols="7")
          v-text-field.mt-2(
            v-model="name"
            :disabled="isLoading"
            :rules="rules.name"
            required
            outlined
            dense
          )
      v-card-actions
        v-btn(
          outlined
          :disabled="isLoading"
          @click="dialog = false"
        ) 閉じる
        v-spacer
        v-btn(
          color="warning"
          elevation="0"
          :disabled="isLoading"
          :loading="isLoading"
          @click="submit"
        ) {{ submitText }}
</template>

<script lang="ts">
import { Component, Prop, PropSync, Vue } from 'nuxt-property-decorator'

@Component
export default class RoomsDashboardGroupFormDialogComponent extends Vue {
  @PropSync('dialogValue', { type: Boolean, required: true }) dialog: boolean

  @PropSync('nameValue', { type: String, required: true }) name: string
  @PropSync('descriptionValue', { type: String, required: true }) description: string

  @Prop({ type: String, required: true }) readonly submitText: string
  @Prop({ type: Function, required: true }) submitFunc: () => Promise<void>

  isLoading = false
  rules = this.$formRules.roomGroup

  submit() {
    this.isLoading = true
  }
}
</script>
