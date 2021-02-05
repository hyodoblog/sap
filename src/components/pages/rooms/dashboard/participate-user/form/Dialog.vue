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
          v-col(cols="5")
            .subtitle-1
              | 表示名
              v-chip.ml-1(x-small) 必須
          v-col(cols="7")
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
          v-col(cols="5")
            .subtitle-1
              | メールアドレス
              v-chip.ml-1(x-small) 必須
          v-col(cols="7")
            v-text-field.mt-2(
              v-model="email"
              :disabled="isLoading"
              :rules="rules.email"
              outlined
              required
              dense
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

        .my-4.text-center(v-if="isEdit")
          v-btn(color="error" text @click="removeDialog = true") 削除する

          v-dialog(
            v-model="removeDialog"
            max-width="400"
            persistent
          )
            v-card
              v-card-title 本当に削除しますか？
              v-card-actions
                v-btn(
                  text
                  :disabled="isRemoveLoading"
                  @click="removeDialog = false"
                ) いいえ
                v-spacer
                v-btn(
                  color="error"
                  elevation="0"
                  :disabled="isRemoveLoading"
                  :loading="isRemoveLoading"
                  @click="remove"
                ) はい
</template>

<script lang="ts">
import { Component, Prop, PropSync, Vue } from 'nuxt-property-decorator'

@Component
export default class RoomsDashboardParticipateUserFormDialogComponent extends Vue {
  @PropSync('dialogValue', { type: Boolean, required: true }) dialog: boolean

  @Prop({ type: String, default: '' }) readonly participateUserUid: string
  @PropSync('displayNameValue', { type: String, required: true }) displayName: string
  @PropSync('emailValue', { type: String, required: true }) email: string

  @Prop({ type: String, required: true }) readonly title: string
  @Prop({ type: String, required: true }) readonly submitText: string
  @Prop({ type: Function, required: true }) submitFunc: () => Promise<void>

  get isEdit(): boolean {
    return !!this.participateUserUid
  }

  isValid = true
  isLoading = false
  rules = this.$formRules.roomPaticipateUser

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
      this.$store.dispatch('room/participate-user/init', roomUid)
      this.isValid = true
      this.isLoading = false
      this.dialog = false
    })
  }

  // remove

  removeDialog = false
  isRemoveLoading = false

  remove() {
    this.isRemoveLoading = true
    const roomUid = this.$route.params.uid
    return this.$fire.store.roomParticipateUser
      .deleteItem(roomUid, this.participateUserUid)
      .then(() => {
        this.$store.dispatch('snackbar/success', `「${this.displayName}」グループを削除しました。`)
        this.$store.dispatch('room/participate-user/init')
        this.dialog = this.removeDialog = false
      })
      .catch(() => {
        this.$store.dispatch('snackbar/error', `「${this.displayName}」グループの削除に失敗しました。`)
      })
      .finally(() => {
        this.isRemoveLoading = false
      })
  }
}
</script>
