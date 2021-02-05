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
            large
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

  async submit() {
    try {
      // バリデーション
      // @ts-ignore
      if (!this.$refs.form.validate()) {
        this.$store.dispatch('snackbar/error', '会員登録済みのメールアドレスです。')
        return
      }

      // サインイン開始

      this.isLoading = true
      this.isSignInDisabled = true

      await this.signIn(this.email, this.password)

      this.$router.push(this.$routes.front.rooms)
    } catch {
      this.$store.dispatch('snackbar/error', 'サインインに失敗しました。')
    } finally {
      this.isLoading = false
      this.isSignInDisabled = false
    }
  }

  async signIn(email: string, password: string) {
    const user = await this.$fire.auth.signInWithEmailAndPassword(email, password)
    const headers = await this.$fire.auth.getAuthHeaders()
    const { token } = await this.$api.back.createCookie({ token: await user.getIdToken() }, headers)
    this.$cookies.set('session', token)
    await this.$store.dispatch('auth/init', { uid: user.uid })
  }

  resetErrors() {
    this.error = false
    this.errorMessages = ''

    this.errorProvider = false
    this.errorProviderMessages = ''
  }
}
</script>
