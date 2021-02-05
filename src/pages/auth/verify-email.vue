<template lang="pug">
  v-card.pa-2
    h1 Please verify the email
    .mb-6.overline Please check your email for the link to verify the email.

    v-btn(
      :loading="isLoading"
      :disabled="disabled"
      block
      depressed
      large
      color="primary"
      @click="resend"
    ) Re-send email {{ seconds }}
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

const TIMEOUT = 10

@Component({
  layout: 'auth',
})
export default class AuthVerifyEmailPage extends Vue {
  isLoading = false
  disabled = true
  times = 0
  secondsToEnable = TIMEOUT
  seconds = ''

  mounted() {
    this.setTimer()
  }

  beforeDestroy() {
    clearInterval()
  }

  resend() {
    this.setTimer()
  }

  setTimer() {
    this.disabled = true
    this.times++
    this.secondsToEnable = TIMEOUT * this.times

    setInterval(() => {
      if (this.secondsToEnable === 0) {
        clearInterval()
        this.seconds = ''
        this.disabled = false
      } else {
        this.seconds = `( ${this.secondsToEnable} )`
        this.secondsToEnable--
      }
    }, 1000)
  }
}
</script>
