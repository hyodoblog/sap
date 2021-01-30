<template lang="pug">
  div
    v-card.text-center.pa-1
      v-card-title.justify-center.display-1.mb-2 アカウントを作成する
      v-card-subtitle Let's build amazing products

      //-- sign up form
      v-card-text
        v-form(ref="form" v-model="isFormValid" lazy-validation)
          v-text-field(
            v-model="nickname"
            :rules="[rules.required]"
            :validate-on-blur="false"
            :error="errorName"
            :error-messages="errorNameMessage"
            label="ニックネーム"
            name="name"
            outlined
            @keyup.enter="submit"
            @change="resetErrors"
          )

          v-text-field(
            v-model="email"
            :rules="[rules.required]"
            :validate-on-blur="false"
            :error="errorEmail"
            :error-messages="errorEmailMessage"
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
            :error="errorPassword"
            :error-messages="errorPasswordMessage"
            label="パスワード"
            name="password"
            outlined
            @change="resetErrors"
            @keyup.enter="submit"
            @click:append="showPassword = !showPassword"
          )

          v-btn(
            :loading="isLoading"
            :disabled="isSignUpDisabled"
            block
            x-large
            color="primary"
            @click="submit"
          ) アカウントを作成する

          .mt-5.overline
            | サインアップすると、
            br
            nuxt-link(to="") 利用規約
            | &
            nuxt-link(to="") 個人情報保護方針

    .text-center.mt-6 すでにアカウントをお持ちですか？
      nuxt-link.font-weight-bold(:to="$routes.front.signin") サインイン
</template>

<script lang="ts">
/*
|---------------------------------------------------------------------
| Sign Up Page Component
|---------------------------------------------------------------------
|
| Template for user sign up with external providers buttons
|
*/
import { Component, Vue } from 'nuxt-property-decorator'
import { User } from '~/modules/types/models'

@Component({
  layout: 'auth',
})
export default class AuthSignupPage extends Vue {
  // sign up buttons
  isLoading = false
  isSignUpDisabled = false

  // form
  isFormValid = true
  email = ''
  password = ''
  nickname = ''

  // form error
  errorName = false
  errorEmail = false
  errorPassword = false
  errorNameMessage = ''
  errorEmailMessage = ''
  errorPasswordMessage = ''

  // show password field
  showPassword = false

  // input rules
  rules = {
    required: (value: any) => (value && Boolean(value)) || '入力してください',
  }

  async submit() {
    try {
      // ユーザー情報を確認
      const isUser = await this.$fire.store.user.isUserToEmail(this.email)
      if (isUser) {
        this.$store.dispatch('snackbar/error', '会員登録済みのメールアドレスです。')
        return
      }

      // バリデーション
      // @ts-ignore
      if (!this.$refs.form.validate()) {
        this.$store.dispatch('snackbar/error', '会員登録済みのメールアドレスです。')
        return
      }

      // 登録開始

      this.isLoading = true
      this.isSignUpDisabled = true

      await this.signUp(this.email, this.password)

      this.$router.push(this.$routes.front.sapApps)
    } catch {
      this.$store.dispatch('snackbar/error', 'サインアップに失敗しました。')
    } finally {
      this.isLoading = false
      this.isSignUpDisabled = false
    }
  }

  async signUp(email: string, password: string) {
    const user = await this.$fire.auth.createUserWithEmailAndPassword(email, password)
    const headers = this.$fire.auth.getAuthHeaders()
    const { token } = await this.$api.back.createCookie({ token: await user.getIdToken() }, headers)
    this.$cookies.set('session', token)
    await this.$store.dispatch('auth/init', { uid: user.uid, nickname: this.nickname })
  }

  resetErrors() {
    this.errorName = false
    this.errorEmail = false
    this.errorPassword = false
    this.errorNameMessage = ''
    this.errorEmailMessage = ''
    this.errorPasswordMessage = ''
  }
}
</script>
