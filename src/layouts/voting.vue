<template lang="pug">
  v-app
    v-main
      nuxt
    Snackbar
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  components: {
    Snackbar: () => import('~/components/Snackbar.vue'),
  },
})
export default class VotingLayout extends Vue {}
</script>
