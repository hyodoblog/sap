<template lang="pug">
  v-row
    v-col
      v-btn(icon :to="link")
        v-icon mdi-arrow-left
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'nuxt-property-decorator'

@Component
export default class BtnPageBack extends Vue {
  @Prop({ type: String, required: true }) readonly link: string
}
</script>
