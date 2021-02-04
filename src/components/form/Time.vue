<template lang="pug">
  v-dialog(
    ref="dialog"
    v-model="dialog"
    :return-value.sync="time"
    width="290px"
  )
    template(#activator="{ on, attrs }")
      v-text-field(
        v-model="time"
        prepend-icon="mdi-clock-time-four-outline"
        :disabled="disabled"
        readonly
        v-bind="attrs"
        v-on="on"
      )
    v-time-picker(
      v-if="dialog"
      v-model="time"
      color="primary"
      full-width
    )
      v-spacer
      v-btn(text color="primary" @click="dialog = false") 閉じる
      v-btn(text color="primary" @click="$refs.dialog.save(time)") 設定
</template>

<script lang="ts">
import { Component, Prop, PropSync, Vue } from 'nuxt-property-decorator'

@Component
export default class FormTimeComponent extends Vue {
  @Prop({ type: Boolean, required: true }) readonly disabled: boolean
  @PropSync('timeValue', { type: String, required: true }) time: string

  dialog = false
}
</script>
