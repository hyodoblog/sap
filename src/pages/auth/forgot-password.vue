<template lang="pug">
  div
    v-card.text-center.pa-1
      v-card-title.justify-center.display-1.mb-2 パスワードをお忘れですか？
      v-card-subtitle アカウントのメールアドレスを入力すると、パスワードをリセットするためのリンクが送信されます。

      v-card-text
        v-form(ref="form" v-model="isFormValid" lazy-validation @submit.prevent="submit")
          v-text-field(
            v-model="email"
            :rules="[rules.required]"
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
            x-large
            color="primary"
            @click="submit"
          ) パスワードリセットのリクエスト

    .text-center.mt-6
      nuxt-link(:to="$routes.front.signin") サインインに戻る
</template>

<script lang="ts">
/*
|---------------------------------------------------------------------
| Forgot Page Component
|---------------------------------------------------------------------
|
| Template to send email to remember/replace password
|
*/
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
    required: (value: any) => (value && Boolean(value)) || 'Required',
  }

  submit(e: any) {
    console.log(e)
    // @ts-ignore
    if (this.$refs.form.validate()) {
      console.log('submit')
    }
  }

  resetEmail(email: string, password: string) {
    console.log(email)
    console.log(password)
  }

  resetErrors() {
    this.error = false
    this.errorMessages = ''
  }
}
</script>
