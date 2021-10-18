<template lang="pug">
  v-snackbar(v-model="isSnackbar" dark bottom right :color="color" :timeout="-1")
    .text-center.title {{ text }}
</template>

<script lang="ts">
import { Component, Vue, Watch } from 'nuxt-property-decorator'

@Component
export default class SnackbarComponent extends Vue {
  get isSnackbar(): boolean {
    return this.$store.getters['snackbar/isSnackbar']
  }

  get text(): string {
    return this.$store.state.snackbar.text
  }

  get color(): string {
    return this.$store.state.snackbar.color
  }

  offSnackbar() {
    this.$store.commit('snackbar/RESET')
  }

  @Watch('isSnackbar', { immediate: true, deep: true })
  close() {
    setTimeout(() => {
      this.offSnackbar()
    }, 4000)
  }
}
</script>

<style lang="scss" scoped>
.close-btn {
  position: absolute;
  right: 0;
  top: 50%;
  transform: translate(-50%, 0);
}
</style>
