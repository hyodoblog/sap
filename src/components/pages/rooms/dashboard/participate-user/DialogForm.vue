<template lang="pug">
  v-dialog(
    v-model="dialog"
    max-width="600"
    persistent
  )
    v-card
      v-row
        v-col(cols="5")
        v-col(cols="7")
      v-card-actions
        v-btn(
          outlined
          @click="dialog = false"
        ) 閉じる
        v-spacer
        v-btn(
          color="warning"
          elevation="0"
          @click="submit"
        ) {{ submitText }}
</template>

<script lang="ts">
import { Component, Prop, PropSync, Vue } from 'nuxt-property-decorator'

@Component
export default class RoomsDashboardParticipateUserDialogFormComponent extends Vue {
  @PropSync('dialogValue', { type: Boolean, required: true }) dialog: boolean

  @Prop({ type: String, required: true }) readonly submitText: string
  @Prop({ type: Function, required: true }) submitFunc: () => Promise<void>

  submit() {}
}
</script>
