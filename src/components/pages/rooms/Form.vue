<template lang="pug">
  v-card.px-4.py-6
    v-form(
      v-model="valid"
      ref="form"
      lazy-validation
    )
      v-row.align-center
        v-col(cols="4")
          .subtitle-1 アイコン
        v-col(cols="8")
          ImgCropForm(
            canvasId="image-canvas"
            :isUpdate="isUpdate"
            :maxWidth="300"
            :maxHeight="300"
            :imgDataURLValue.sync="imgDataURL"
            :disabled="disabled"
            @input="change"
          )

      v-divider.my-4

      v-row.align-center
        v-col(cols="4")
          .subtitle-1
            | 名前
            v-chip.ml-1(x-small) 必須
        v-col(cols="8")
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
      
      v-divider.my-4
      v-row.align-center
        v-col(cols="4")
          .subtitle-1
            | 説明
            v-chip.ml-1(x-small) 必須
        v-col(cols="8")
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
      
      v-divider.my-4

      v-row.align-center
        v-col.py-2(cols="4")
          .subtitle-1
            | 開始日時
            v-chip.ml-1(x-small) 必須
        v-col.py-2(cols="8")
          DatetimeForm(:datetimeValue.sync="startAtTime")

      v-divider.my-4

      v-row.align-center
        v-col.py-2(cols="4")
          .subtitle-1
            | 投票締め切り日時
            v-chip.ml-1(x-small) 必須
        v-col.py-2(cols="8")
          DatetimeForm(:datetimeValue.sync="votingEndAtTime")

      v-divider.my-4

      v-row.align-center
        v-col.py-2(cols="4")
          .subtitle-1
            | 閲覧終了日時
            v-chip.ml-1(x-small) 必須
        v-col.py-2(cols="8")
          DatetimeForm(:datetimeValue.sync="browsingEndAtTime")
  
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
import { Component, Prop, PropSync, mixins, Watch } from 'nuxt-property-decorator'
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

  // form date
  date = ''
  setDate() {
    const year = this.startAt.getFullYear()
    const month = this.startAt.getMonth() + 1 >= 10 ? this.startAt.getMonth() + 1 : `0${this.startAt.getMonth() + 1}`
    const date = this.startAt.getDate() >= 10 ? this.startAt.getDate() : `0${this.startAt.getDate()}`
    this.date = `${year}-${month}-${date}`
  }

  @Watch('date')
  changeDate() {
    const at = this.startAt
    const Hours = at.getHours() >= 10 ? String(at.getHours()) : `0${at.getHours()}`
    const Minutes = at.getMinutes() >= 10 ? String(at.getMinutes()) : `0${at.getMinutes()}`

    this.startAt = new Date(`${this.date}T${Hours}:${Minutes}`)
  }

  // ---------------------
  // time

  get startAtTime(): string {
    const date = new Date(this.startAt)
    return `${date.getHours() >= 10 ? date.getHours() : `0${date.getHours()}`}:${
      date.getMinutes() >= 10 ? date.getMinutes() : `0${date.getMinutes()}`
    }`
  }

  set startAtTime(time: string) {
    const at = this.startAt
    const year = at.getFullYear()
    const month = at.getMonth() + 1 >= 10 ? String(at.getMonth() + 1) : `0${at.getMonth() + 1}`
    const date = at.getDate() >= 10 ? String(at.getDate()) : `0${at.getDate()}`
    this.startAt = new Date(`${year}-${month}-${date}T${time}:00`)
  }

  get votingEndAtTime(): string {
    const date = new Date(this.votingEndAt)
    return `${date.getHours() >= 10 ? date.getHours() : `0${date.getHours()}`}:${
      date.getMinutes() >= 10 ? date.getMinutes() : `0${date.getMinutes()}`
    }`
  }

  set votingEndAtTime(time: string) {
    const at = this.votingEndAt
    const year = at.getFullYear()
    const month = at.getMonth() + 1 >= 10 ? String(at.getMonth() + 1) : `0${at.getMonth() + 1}`
    const date = at.getDate() >= 10 ? String(at.getDate()) : `0${at.getDate()}`
    this.votingEndAt = new Date(`${year}-${month}-${date}T${time}:00`)
  }

  get browsingEndAtTime(): string {
    const date = new Date(this.browsingEndAt)
    return `${date.getHours() >= 10 ? date.getHours() : `0${date.getHours()}`}:${
      date.getMinutes() >= 10 ? date.getMinutes() : `0${date.getMinutes()}`
    }`
  }

  set browsingEndAtTime(time: string) {
    const at = this.browsingEndAt
    const year = at.getFullYear()
    const month = at.getMonth() + 1 >= 10 ? String(at.getMonth() + 1) : `0${at.getMonth() + 1}`
    const date = at.getDate() >= 10 ? String(at.getDate()) : `0${at.getDate()}`
    this.browsingEndAt = new Date(`${year}-${month}-${date}T${time}:00`)
  }

  @Watch('startAt')
  changeStartAt() {
    let at = new Date(this.startAt)
    at.setHours(at.getHours() + 1)
    at.setMinutes(at.getMinutes() + 30)
    this.votingEndAt = at

    at = new Date(this.votingEndAt)
    at.setMinutes(at.getMinutes() + 30)
    this.browsingEndAt = at
  }

  @Watch('votingEndAt')
  changeLastOrderAt() {
    const at = new Date(this.votingEndAt)
    at.setMinutes(at.getMinutes() + 30)
    this.browsingEndAt = at
  }

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
        this.$router.push(this.$routes.front.rooms)
      })
      .finally(() => {
        this.disabled = this.submitLoading = false
        this.valid = true
      })
  }
}
</script>
