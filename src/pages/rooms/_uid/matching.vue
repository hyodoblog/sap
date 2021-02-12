<template lang="pug">
  v-container.px-2(fluid)
    //- loading
    v-overlay(v-if="!isAuthenticated")
      v-progress-circular(indeterminate size="64")

    template(v-else)
      .title マッチングページ
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  layout: 'public',
})
export default class RoomMatchingPage extends Vue {
  get roomUid(): string {
    return this.$route.params.uid
  }

  get isAuthenticated(): boolean {
    return this.$store.getters['invitation/isAuthenticated']
  }
}
</script>
