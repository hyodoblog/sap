<template lang="pug">
  v-card.v-card--material.pa-3(v-bind="$attrs" :class="classes")
    .d-flex.grow.flex-wrap
      v-avatar.mx-auto.v-card--material__avatar.elevation-6(v-if="avatar" size="128" color="grey")
        v-img(:src="avatar")

      v-sheet(
        v-else
        :class="{'pa-7': !$slots.image}"
        :color="color"
        :max-height="icon ? 90 : undefined"
        :width="inline || icon ? 'auto' : '100%'"
        elevation="6"
        class="text-start v-card--material__heading mb-n6"
      )
        slot(v-if="$slots.heading" name="heading")

        slot(v-else-if="$slots.image" name="image")

        .display-1.font-weight-light(v-else-if="title && !icon" v-text="title")

        v-icon(v-else-if="icon" size="32" v-text="icon")

        .headline.font-weight-thin(v-if="text" v-text="text")

      .ml-6(v-if="$slots['after-heading']")
        slot(name="after-heading")

      v-col.text-center.py-0.mt-n12(v-if="hoverReveal" cols="12")
        slot(name="reveal-actions")

      .ml-4(v-else-if="icon && title")
        .card-title.font-weight-light(v-text="title")
  
    slot

    template(v-if="$slots.actions")
      v-divider.mt-2

      v-card-actions.pb-0
        slot(name="actions")
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'nuxt-property-decorator'

@Component
export default class BaseMaterialCard extends Vue {
  @Prop({ type: String, default: '' }) private readonly avatar!: string
  @Prop({ type: String, default: 'success' }) private readonly color!: string
  @Prop({ type: Boolean, default: false }) private readonly hoverReveal!: boolean
  @Prop({ type: String, default: undefined }) private readonly icon!: string
  @Prop({ type: Boolean, default: false }) private readonly image!: boolean
  @Prop({ type: Boolean, default: false }) private readonly inline!: boolean
  @Prop({ type: String, default: '' }) private readonly text!: string
  @Prop({ type: String, default: '' }) private readonly title!: string

  private get classes() {
    return {
      'v-card--material--has-heading': this.hasHeading,
      'v-card--material--hover-reveal': this.hoverReveal,
    }
  }

  private get hasHeading() {
    return Boolean(this.$slots.heading || this.title || this.icon)
  }

  private get hasAltHeading() {
    return Boolean(this.$slots.heading || (this.title && this.icon))
  }
}
</script>

<style lang="sass">
.v-card--material
  &__avatar
    position: relative
    top: -64px
    margin-bottom: -32px

  &__heading
    position: relative
    top: -40px
    transition: .3s ease
    z-index: 1

  &.v-card--material--hover-reveal:hover
    .v-card--material__heading
      transform: translateY(-40px)
</style>
