<template lang="pug">
  section
    img(src="home.jpg")
    h1 研究室マッチングシステム
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component
export default class extends Vue {}
</script>

<style lang="scss" scoped>
section {
  position: relative;
  width: 100%;
  height: 100vh;

  * {
    position: absolute;
  }

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  h1 {
    bottom: 10%;
    left: 50%;
    transform: translate(-50%);
    white-space: nowrap;
  }
}
</style>
