<template lang="pug">
  v-container(fluid)
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  layout: 'protected',
})
export default class AppsPage extends Vue {}
</script>
