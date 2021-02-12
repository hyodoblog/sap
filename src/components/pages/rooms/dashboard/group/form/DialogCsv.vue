<template lang="pug">
  v-dialog(
    v-model="dialog"
    max-width="600"
    persistent
  )
    v-card.px-4.py-6
      v-form(
        ref="form"
        v-model="isValid"
        lazy-validation
      )
        .d-flex.justify-space-between.align-center
          .title.font-weight-bold {{ title }}
          v-btn(icon @click="dialog = false")
            v-icon mdi-close

        v-divider.my-3

        v-row.align-center
          v-col(cols="5")
            .subtitle-1
              | CSVファイル
              v-chip.ml-1(x-small) 必須
          v-col(cols="7")
            v-file-input.mt-2(
              v-model="file"
              accept=".csv"
              outlined
              @change="changeFile"
            )

        v-divider.my-3

        v-card-actions
          v-btn(
            large
            color="warning"
            elevation="0"
            :disabled="isLoading"
            :loading="isLoading"
            @click="submit"
          ) {{ submitText }}
</template>

<script lang="ts">
import { Component, Prop, PropSync, Vue } from 'nuxt-property-decorator'

@Component
export default class RoomDashboardGroupFormDialogCsvComponent extends Vue {
  @PropSync('dialogValue', { type: Boolean, required: true }) dialog!: boolean

  @Prop({ type: String, required: true }) readonly title: string
  @Prop({ type: String, required: true }) readonly submitText: string
  @Prop({ type: Function, required: true }) submitFunc: () => Promise<void>

  isValid = true
  isLoading = false

  file: File | null = null

  changeFile(file: File | null) {
    if (file !== null) {
      console.log(file)
    }
  }

  submit() {
    // @ts-ignore
    if (!this.$refs.form.validate()) {
      this.$store.dispatch('snackbar/error', '入力に誤りがあります。')
      return
    }

    this.isValid = false
    this.isLoading = true

    return this.submitFunc().finally(() => {
      const roomUid = this.$route.params.uid
      this.$store.dispatch('room/group/init', roomUid)
      this.isValid = true
      this.isLoading = false
      this.dialog = false
      // reset
    })
  }
}
</script>
