<template lang="pug">
  v-app
</template>

<script>
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  layout: 'auth',
})
export default class DashboardPage extends Vue {}
</script>
