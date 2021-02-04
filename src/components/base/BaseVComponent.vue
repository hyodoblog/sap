<template lang="pug">
  section.text-left
    h1.font-weight-light.my-2.headline
      v-icon(style="font-size:24px").mr-2 {{ icon }}
      | {{ title }}

    span.font-weight-light.subtitle-1 {{ subTitle }}
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'nuxt-property-decorator'

@Component
export default class extends Vue {
  @Prop({ type: String, required: true, default: '' }) private readonly title: string
  @Prop({ type: String, required: true }) private readonly icon: string
  @Prop({ type: String, default: '' }) private readonly subTitle: string
}
</script>
