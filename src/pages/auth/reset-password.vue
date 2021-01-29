<template lang="pug">
  v-card.pa-2
    v-card-title.justify-center.display-1.mb-2 Set new password
    .overline {{ status }}
    .error--text.mt-2.mb-4 {{ error }}

    a(v-if="error" href="/") Back to Sign In

    v-text-field(
      v-model="newPassword"
      :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
      :rules="[rules.required]"
      :type="showPassword ? 'text' : 'password'"
      :error="errorNewPassword"
      :error-messages="errorNewPasswordMessage"
      name="password"
      label="New Password"
      outlined
      class="mt-4"
      @change="resetErrors"
      @keyup.enter="confirmPasswordReset"
      @click:append="showPassword = !showPassword"
    )

    v-btn(
      :loading="isLoading"
      block
      depressed
      x-large
      color="primary"
      @click="confirmPasswordReset"
    ) Set new password and Sign In
</template>

<script lang="ts">
/*
|---------------------------------------------------------------------
| Reset Page Component
|---------------------------------------------------------------------
|
| Page Form to insert new password and proceed to sign in
|
*/
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  layout: 'auth',
})
export default class AuthResetPasswordPage extends Vue {
  isLoading = false

  showNewPassword = true
  newPassword = ''

  // form error
  errorNewPassword = false
  errorNewPasswordMessage = ''

  // show password field
  showPassword = false

  status = 'Resetting password'
  error = null

  // input rules
  rules = {
    required: (value: any) => (value && Boolean(value)) || '入力してください',
  }

  confirmPasswordReset() {
    this.isLoading = true

    setTimeout(() => {
      this.isLoading = false
    }, 500)
  }

  resetErrors() {
    this.errorNewPassword = false
    this.errorNewPasswordMessage = ''
  }
}
</script>
