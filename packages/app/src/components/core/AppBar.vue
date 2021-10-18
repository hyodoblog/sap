<template lang="pug">
  v-app-bar(app)
    v-app-bar-nav-icon(@click="drawer = !drawer")
</template>

<script lang="ts">
import { Component, PropSync, Vue } from 'nuxt-property-decorator'

@Component
export default class CoreAppBarComponent extends Vue {
  @PropSync('drawerValue', { type: Boolean || null, default: null }) drawer: boolean | null
}
</script>
