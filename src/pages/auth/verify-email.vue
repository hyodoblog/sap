<template lang="pug">
  v-card.pa-2
    h1 Please verify the email
    .mb-6.overline Please check your email for the link to verify the email.

    v-btn(
      :loading="isLoading"
      :disabled="disabled"
      block
      depressed
      x-large
      color="primary"
      @click="resend"
    ) Re-send email {{ seconds }}
</template>

<script lang="ts">
/*
|---------------------------------------------------------------------
| Verify Email Page Component
|---------------------------------------------------------------------
|
| Template to wait for the verification on the user email
|
*/
import { Component, Vue } from 'nuxt-property-decorator'

const TIMEOUT = 10

@Component({
  layout: 'auth',
  data() {
    return {
      isLoading: false,
      disabled: true,
      times: 0,
      resendInterval: null,
      secondsToEnable: TIMEOUT,
      seconds: '',
    }
  },
  mounted() {
    this.setTimer()
  },
  beforeDestroy() {
    clearInterval(this.resendInterval)
  },
  methods: {
    async resend() {
      this.setTimer()
    },
    setTimer() {
      this.disabled = true
      this.times++
      this.secondsToEnable = TIMEOUT * this.times

      this.resendInterval = setInterval(() => {
        if (this.secondsToEnable === 0) {
          clearInterval(this.resendInterval)
          this.seconds = ''
          this.disabled = false
        } else {
          this.seconds = `( ${this.secondsToEnable} )`
          this.secondsToEnable--
        }
      }, 1000)
    },
  },
})
export default class AuthVerifyEmailPage extends Vue {}
</script>
