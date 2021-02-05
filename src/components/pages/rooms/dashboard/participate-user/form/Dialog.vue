<template lang="pug">
  v-dialog(
    v-model="dialog"
    max-width="600"
    persistent
  )
    v-card.px-4.py-6
      v-form(
        ref="form"
        v-model="isValid"
        lazy-validation
      )
        v-row
          v-col.py-0(cols="12")
            v-btn(icon @click="dialog = false")
              v-icon mdi-close

        v-row.align-center
          v-col(cols="4")
            .subtitle-1
              | 表示名
              v-chip.ml-1(x-small) 必須
          v-col(cols="8")
            v-text-field.mt-2(
              v-model="displayName"
              :disabled="isLoading"
              :rules="rules.displayName"
              required
              outlined
              dense
            )

        v-divider.my-3
</template>

<script lang="ts">
import { Component, Prop, PropSync, Vue } from 'nuxt-property-decorator'

@Component
export default class RoomsDashboardParticipateUserFormDialogComponent extends Vue {
  @PropSync('dialogValue', { type: Boolean, required: true }) dialog: boolean

  @PropSync('groupUidValue', { type: String, required: true }) groupUid: string
  @PropSync('displayNameValue', { type: String, required: true }) displayName: string
  @PropSync('emailValue', { type: String, required: true }) email: string
  @PropSync('maxNumValue', { type: Number || null, required: true }) maxNum: number | null

  @Prop({ type: String, required: true }) readonly submitText: string
  @Prop({ type: Function, required: true }) submitFunc: () => Promise<void>

  rules = this.$formRules.roomPaticipateUser

  submit() {}
}
</script>
