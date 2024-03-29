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
            large
            color="primary"
            @click="submit"
          ) アカウントを作成する

    .text-center.mt-6 すでにアカウントをお持ちですか？
      nuxt-link.font-weight-bold(:to="$routes.front.signin") サインイン
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

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
      // バリデーション
      // @ts-ignore
      if (!this.$refs.form.validate()) return

      // 登録開始

      this.isLoading = true
      this.isSignUpDisabled = true

      await this.signUp(this.email, this.password)

      this.$router.push(this.$routes.front.rooms)
      this.$store.dispatch('snackbar/success', 'サインアップが完了しました')
    } catch {
      this.$store.dispatch('snackbar/error', 'サインアップに失敗しました')
    } finally {
      this.isLoading = false
      this.isSignUpDisabled = false
    }
  }

  async signUp(email: string, password: string) {
    const user = await this.$fire.auth.createUserWithEmailAndPassword(email, password)
    const headers = await this.$fire.auth.getAuthHeaders()
    const { token } = await this.$api.back.createCookie({ token: await user.getIdToken() }, headers)
    this.$cookies.set('session', token)
    await this.$store.dispatch('user/init', { uid: user.uid, nickname: this.nickname, email: this.email })
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
