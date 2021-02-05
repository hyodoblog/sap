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
          v-col(cols="12")
            v-btn(icon @click="dialog = false")
              v-icon mdi-close

        v-divider.my-4

        v-row.align-center
          v-col(cols="4")
            .subtitle-1
              | 名前
              v-chip.ml-1(x-small) 必須
          v-col(cols="8")
            v-text-field.mt-2(
              v-model="name"
              :disabled="isLoading"
              :rules="rules.name"
              required
              outlined
              dense
            )

        v-divider.my-4

        v-row.align-center
          v-col(cols="4")
            .subtitle-1 説明
          v-col(cols="8")
            v-text-field.mt-2(
              v-model="description"
              :disabled="isLoading"
              :rules="rules.description"
              outlined
              dense
            )

        v-divider.my-4

        v-row.align-center
          v-col(cols="4")
            .subtitle-1
              | 優先度
              v-chip.ml-1(x-small) 必須
          v-col(cols="8")
            v-text-field.mt-2(
              v-model.number="priority"
              :disabled="isLoading"
              :rules="rules.priority"
              hint="0~10の間で入力してください。大きいほど優先度が高くなります。"
              persistent-hint
              type="number"
              required
              outlined
              dense
              @input="setPriority"
            )

        v-divider.my-4

        v-card-actions
          v-btn(
            x-large
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
  @PropSync('priorityValue', { type: Number, required: true }) priority: number

  @Prop({ type: String, required: true }) readonly submitText: string
  @Prop({ type: Function, required: true }) submitFunc: () => Promise<void>

  isValid = true
  isLoading = false
  rules = this.$formRules.roomGroup

  setPriority(num: string) {
    this.priority = Number(num)
  }

  submit() {
    // @ts-ignore
    if (!this.$refs.form.validate()) {
      this.$store.dispatch('snackbar/error', '入力に誤りがあります。')
      return
    }

    this.isValid = false
    this.isLoading = true

    return this.submitFunc().finally(() => {
      const roomUid = this.$route.params.uid
      this.$store.dispatch('room/group/init', roomUid)
      this.isValid = true
      this.isLoading = false
      this.dialog = false
    })
  }
}
</script>
