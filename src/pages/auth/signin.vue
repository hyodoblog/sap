<template lang="pug">
  div
    v-card.text-center.pa-1
      v-card-title.justify-center.display-1.mb-2 Welcome
      v-card-subtitle Sign in to your account

      //- sign in form
      v-card-text
        v-form(ref="form" v-model="isFormValid" lazy-validation)
          v-text-field(
            v-model="email"
            :rules="[rules.required]"
            :validate-on-blur="false"
            :error="error"
            label="Eメール"
            name="email"
            outlined
            @keyup.enter="submit"
            @change="resetErrors"
          )

          v-text-field(
            v-model="password"
            :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
            :rules="[rules.required]"
            :type="showPassword ? 'text' : 'password'"
            :error="error"
            :error-messages="errorMessages"
            label="パスワード"
            name="password"
            outlined
            @change="resetErrors"
            @keyup.enter="submit"
            @click:append="showPassword = !showPassword"
          )

          v-btn(
            :loading="isLoading"
            :disabled="isSignInDisabled"
            block
            x-large
            color="primary"
            @click="submit"
          ) サインイン

          .mt-5
            nuxt-link(:to="$routes.front.forgotPassword") パスワードをお忘れですか？

    .text-center.mt-6 アカウントをお持ちではありませんか？
      nuxt-link.font-weight-bold(:to="$routes.front.signup") ここで作成します
</template>

<script lang="ts">
/*
|---------------------------------------------------------------------
| Sign In Page Component
|---------------------------------------------------------------------
|
| Sign in template for user authentication into the application
|
*/
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  layout: 'auth',
})
export default class AuthSigninPage extends Vue {
  // sign in buttons
  isLoading = false
  isSignInDisabled = false

  // form
  isFormValid = true
  email = ''
  password = ''

  // form error
  error = false
  errorMessages = ''

  errorProvider = false
  errorProviderMessages = ''

  // show password field
  showPassword = false

  // input rules
  rules = {
    required: (value: any) => (value && Boolean(value)) || '入力してください',
  }

  submit() {
    // @ts-ignore
    if (this.$refs.form.validate()) {
      this.isLoading = true
      this.isSignInDisabled = true
      this.signIn(this.email, this.password)
    }
  }

  signIn(email: string, password: string) {
    console.log(email)
    console.log(password)
    this.$router.push('/')
  }

  resetErrors() {
    this.error = false
    this.errorMessages = ''

    this.errorProvider = false
    this.errorProviderMessages = ''
  }
}
</script>
