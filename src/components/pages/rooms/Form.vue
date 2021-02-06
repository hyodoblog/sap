<template lang="pug">
  v-card.px-4.py-6
    v-form(
      v-model="valid"
      ref="form"
      lazy-validation
    )
      v-row.align-center
        v-col(cols="5")
          .subtitle-1 アイコン
        v-col(cols="7")
          ImgCropForm(
            canvasId="image-canvas"
            :isUpdate="isUpdate"
            :maxWidth="300"
            :maxHeight="300"
            :imgDataURLValue.sync="imgDataURL"
            :disabled="disabled"
            @input="change"
          )

      v-divider.my-3

      v-row.align-center
        v-col(cols="5")
          .subtitle-1
            | 表示名
            v-chip.ml-1(x-small) 必須
        v-col(cols="7")
          v-text-field.mt-2(
            v-model="name"
            :disabled="disabled"
            :rules="rules.name"
            counter="30"
            required
            outlined
            dense
            @input="change"
          )
      
      v-divider.my-3

      v-row.align-center
        v-col(cols="5")
          .subtitle-1 説明
        v-col(cols="7")
          v-text-field.mt-2(
            v-model="description"
            :disabled="disabled"
            :rules="rules.description"
            counter="100"
            required
            outlined
            dense
            @input="change"
          )
      
      v-divider.mt-3.mb-4

      v-row.align-center
        v-col.py-2(cols="5")
          .subtitle-1
            | 開始日時
            v-chip.ml-1(x-small) 必須
        v-col.py-2(cols="7")
          DatetimeForm(
            datetimeId="startAt"
            :datetimeValue.sync="startAt"
          )

      v-divider.my-4

      v-row.align-center
        v-col.py-2(cols="5")
          .subtitle-1
            | 投票締め切り日時
            v-chip.ml-1(x-small) 必須
        v-col.py-2(cols="7")
          DatetimeForm(
            datetimeId="votingEndAt"
            :datetimeValue.sync="votingEndAt"
          )

      v-divider.my-4

      v-row.align-center
        v-col.py-2(cols="5")
          .subtitle-1
            | 閲覧終了日時
            v-chip.ml-1(x-small) 必須
        v-col.py-2(cols="7")
          DatetimeForm(
            datetimeId="browsingEndAt"
            :datetimeValue.sync="browsingEndAt"
          )
  
      v-divider.my-4

      v-btn(
        color="warning"
        elevation="0"
        :disabled="disabled"
        :loading="submitLoading"
        large
        @click="submit"
      ) {{ submitText }}
      v-btn.ml-3(
        v-if="isUpdate && isBlockUnload"
        elevation="0"
        :disabled="disabled"
        :loading="resetLoading"
        outlined
        large
        @click="reset"
      ) 編集を戻す
</template>

<script lang="ts">
import { Component, Prop, PropSync, mixins } from 'nuxt-property-decorator'
import BlockUnloadMixin from '~/mixins/BlockUnload'
// import { App } from '~/modules/types/models'
const ImgCropForm = () => import('~/components/form/ImgCrop.vue')
const DatetimeForm = () => import('~/components/form/Datetime.vue')

@Component({
  components: { ImgCropForm, DatetimeForm },
})
export default class extends mixins(BlockUnloadMixin) {
  @Prop({ type: String, required: true }) readonly submitText: string

  @Prop({ type: String, default: '' }) readonly uid: string
  @PropSync('imgDataURLValue', { type: String, required: true }) imgDataURL: string
  @PropSync('nameValue', { type: String, required: true }) name: string
  @PropSync('descriptionValue', { type: String, required: true }) description: string
  @PropSync('startAtValue', { type: Date, required: true }) startAt: Date
  @PropSync('votingEndAtValue', { type: Date, required: true }) votingEndAt: Date
  @PropSync('browsingEndAtValue', { type: Date, required: true }) browsingEndAt: Date

  @Prop({ type: Function, required: true }) submitFunc: () => Promise<void>
  @Prop({ type: Function, default: () => {} }) resetFunc: () => Promise<void>

  // form config
  valid = true
  disabled = false
  loading = false
  submitLoading = false
  resetLoading = false
  rules = this.$formRules.room

  get isUpdate(): boolean {
    return !!this.uid
  }

  change() {
    this.isBlockUnload = true
  }

  reset() {
    this.disabled = this.resetLoading = true
    if (this.isUpdate) {
      this.resetFunc()
        .catch(() => {
          this.$store.dispatch('snackbar/error', 'SAP情報の取得に失敗しました')
        })
        .finally(() => {
          this.disabled = this.resetLoading = false
        })
    }
  }

  submit() {
    // @ts-ignore
    if (!this.$refs.form.validate()) {
      return
    }

    this.valid = false
    this.disabled = this.submitLoading = true
    this.submitFunc()
      .then(() => {
        this.$store.dispatch('room/init')
        this.isBlockUnload = false
      })
      .finally(() => {
        this.disabled = this.submitLoading = false
        this.valid = true
      })
  }
}
</script>
