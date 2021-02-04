<template lang="pug">
  v-dialog(
    ref="dialog"
    v-model="dialog"
    :return-value.sync="date"
    width="290px"
  )
    template(#activator="{ on, attrs }")
      v-text-field(
        v-model="date"
        prepend-icon="mdi-calendar"
        :disabled="disabled"
        readonly
        v-bind="attrs"
        v-on="on"
      )
    v-date-picker(
      v-model="date"
      color="primary"
      scrollable
    )
      v-spacer
      v-btn(text color="primary" @click="dialog = false") 閉じる
      v-btn(text color="primary" @click="$refs.dialog.save(date)") 設定
</template>

<script lang="ts">
import { Component, Prop, PropSync, Vue } from 'nuxt-property-decorator'

@Component
export default class FormDateComponent extends Vue {
  @Prop({ type: Boolean, required: true }) readonly disabled: boolean
  @PropSync('dateValue', { type: String, required: true }) date: string

  dialog = false
}
</script>
