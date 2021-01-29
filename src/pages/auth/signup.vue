<template lang="pug">
  div
    v-card.text-center.pa-1
      v-card-title.justify-center.display-1.mb-2 アカウントを作成する
      v-card-subtitle Let's build amazing products

      //-- sign up form
      v-card-text
        v-form(ref="form" v-model="isFormValid" lazy-validation)
          v-text-field(
            v-model="name"
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

@Component({
  layout: 'auth',
  data() {
    return {
      // sign up buttons
      isLoading: false,
      isSignUpDisabled: false,

      // form
      isFormValid: true,
      email: '',
      password: '',
      name: '',

      // form error
      errorName: false,
      errorEmail: false,
      errorPassword: false,
      errorNameMessage: '',
      errorEmailMessage: '',
      errorPasswordMessage: '',

      errorProvider: false,
      errorProviderMessages: '',

      // show password field
      showPassword: false,

      // external providers
      providers: [{
        id: 'google',
        label: 'Google',
        isLoading: false
      }, {
        id: 'facebook',
        label: 'Facebook',
        isLoading: false
      }],

      // input rules
      rules: {
        required: (value) => (value && Boolean(value)) || 'Required'
      }
    }
  },
  methods: {
    submit() {
      if (this.$refs.form.validate()) {
        this.isLoading = true
        this.isSignUpDisabled = true
        this.signUp(this.email, this.password)
      }
    },
    signUp(email, password) {},
    signInProvider(provider) {},
    resetErrors() {
      this.errorName = false
      this.errorEmail = false
      this.errorPassword = false
      this.errorNameMessage = ''
      this.errorEmailMessage = ''
      this.errorPasswordMessage = ''

      this.errorProvider = false
      this.errorProviderMessages = ''
    }
  }
})
export default class AuthSignupPage extends Vue {}
</script>
