<template lang="pug">
  div
    v-card.text-center.pa-1
      v-card-title.justify-center.display-1.mb-2 パスワードをお忘れですか？
      v-card-subtitle アカウントのメールアドレスを入力すると、パスワードをリセットするためのリンクが送信されます。

      v-card-text
        v-form(ref="form" v-model="isFormValid" lazy-validation @submit.prevent="submit")
          v-text-field(
            v-model="email"
            :rules="rules.email"
            :validate-on-blur="false"
            :error="error"
            :error-messages="errorMessages"
            label="メールアドレス"
            name="email"
            outlined
            @keyup.enter="submit"
            @change="resetErrors"
          )

          v-btn(
            :loading="isLoading"
            block
            large
            color="primary"
            @click="submit"
          ) パスワードリセットのリクエスト

    .text-center.mt-6
      nuxt-link(:to="$routes.front.signin") サインインに戻る
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  layout: 'auth',
})
export default class AuthForgotPasswordPage extends Vue {
  // reset button
  isLoading = false

  // form
  isFormValid = true
  email = ''

  // form error
  error = false
  errorMessages = ''

  // input rules
  rules = {
    email: [
      (value: any) => (value && Boolean(value)) || 'Required',
      (v: any) => /.+@.+\..+/.test(v) || 'メールアドレス形式で入力してください',
    ],
  }

  submit() {
    // @ts-ignore
    if (this.$refs.form.validate()) {
      this.isLoading = true
      this.resetEmail(this.email).finally(() => {
        this.$store.dispatch('snackbar/success', '登録済みの場合、メールアドレスにリセットリンクを送信しました。')
        this.isLoading = false
      })
    }
  }

  async resetEmail(email: string) {
    await this.$fire.auth.verifyPasswordResetCode(email)
  }

  resetErrors() {
    this.error = false
    this.errorMessages = ''
  }
}
</script>
