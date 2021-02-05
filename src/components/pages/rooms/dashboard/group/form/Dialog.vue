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
        .d-flex.justify-space-between.align-center
          .title.font-weight-bold {{ title }}
          v-btn(icon @click="dialog = false")
            v-icon mdi-close

        v-divider.my-3

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

        v-divider.my-3

        v-row.align-center
          v-col(cols="4")
            .subtitle-1
              | 最大参加人数
              v-chip.ml-1(x-small) 必須
          v-col(cols="8")
            v-text-field.mt-2(
              v-model.number="maxNum"
              :disabled="isLoading"
              :rules="rules.maxNum"
              hint="無制限にする場合は「0」を記入する"
              persistent-hint
              type="number"
              required
              outlined
              dense
              @input="setMaxNum"
            )

        v-divider.my-3

        v-card-actions
          v-btn(
            large
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

  @PropSync('displayNameValue', { type: String, required: true }) displayName: string
  @PropSync('descriptionValue', { type: String, required: true }) description: string
  @PropSync('maxNumValue', { type: Number, required: true }) maxNum: number

  @Prop({ type: String, required: true }) readonly title: string
  @Prop({ type: String, required: true }) readonly submitText: string
  @Prop({ type: Function, required: true }) submitFunc: () => Promise<void>

  isValid = true
  isLoading = false
  rules = this.$formRules.roomGroup

  setMaxNum(num: string) {
    this.maxNum = Number(num)
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
