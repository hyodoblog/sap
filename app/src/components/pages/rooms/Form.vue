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
      
      v-divider.my-3

      v-row.align-center
        v-col(cols="5")
          .subtitle-1
            | 公開する
            v-chip.ml-1(x-small) 必須
        v-col(cols="7")
          v-checkbox.mt-2(
            v-model="isPublic"
            :disabled="disabled"
            hint="公開にすると誰でも参加できます。"
            persistent-hint
            color="red"
            required
            outlined
            dense
            @input="change"
          )
      
      v-divider.mt-3.mb-4

      //- group

      .subtitle-1.font-italic.mb-2 グループ設定

      v-card.pa-4(outlined)

        v-row.align-center
          v-col(cols="5")
            .subtitle-1 表示名
          v-col(cols="7")
            v-text-field(
              v-model="groupDisplayName"
              :disabled="disabled"
              :rules="rules.displayName"
              counter="15"
              required
              outlined
              dense
              @input="change"
            )
        
        v-divider.my-2

        v-row.align-center
          v-col(cols="5")
            .subtitle-1 編集権限
          v-col(cols="7")
            v-checkbox(
              v-model="groupIsEdit"
              label="編集権限を与えますか？"
              :disabled="disabled"
              @input="change"
            )
        
        v-divider.my-2

        v-row.align-center
            v-col(cols="5")
              .subtitle-1 最大希望提出数
            v-col(cols="7")
              v-checkbox(
                v-model="isGroupHopeMaxNum"
                label="設定しますか？"
                hint="設定しない場合は無制限になります。"
                :persistent-hint="!isGroupHopeMaxNum"
                :disabled="disabled"
              )
              v-text-field.mt-2(
                v-if="isGroupHopeMaxNum"
                v-model.number="groupHopeMaxNum"
                :disabled="disabled"
                :rules="rules.maxNum"
                hint="無制限にする場合は「0」を記入する"
                persistent-hint
                type="number"
                required
                outlined
                dense
              )

      v-divider.mt-3.mb-4

      //- particiapte user

      .subtitle-1.font-italic.mb-2 参加者設定

      v-card.pa-4(outlined)
      
        v-row.align-center
          v-col(cols="5")
            .subtitle-1 表示名
          v-col(cols="7")
            v-text-field(
              v-model="participateUserDisplayName"
              :disabled="disabled"
              :rules="rules.displayName"
              counter="15"
              required
              outlined
              dense
              @input="change"
            )
        
        v-divider.my-2

        v-row.align-center
          v-col(cols="5")
            .subtitle-1 編集権限
          v-col(cols="7")
            v-checkbox(
              v-model="participateUserIsEdit"
              label="編集権限を与えますか？"
              :disabled="disabled"
              @input="change"
            )
        
        v-divider.my-2

        v-row.align-center
          v-col(cols="5")
            .subtitle-1 最大希望提出数
          v-col(cols="7")
            v-checkbox(
              v-model="isParticipateUserHopeMaxNum"
              label="設定しますか？"
              hint="設定しない場合は無制限になります。"
              :persistent-hint="!isParticipateUserHopeMaxNum"
              :disabled="disabled"
            )
            v-text-field.mt-2(
              v-if="isParticipateUserHopeMaxNum"
              v-model.number="participateUserHopeMaxNum"
              :rules="rules.maxNum"
              hint="無制限にする場合は「0」を記入する"
              :disabled="disabled"
              persistent-hint
              type="number"
              required
              outlined
              dense
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
            | 希望提出締め切り日時
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
import { Component, Prop, PropSync, mixins, Watch } from 'nuxt-property-decorator'
import BlockUnloadMixin from '~/mixins/BlockUnload'
const ImgCropForm = () => import('~/components/form/ImgCrop.vue')
const DatetimeForm = () => import('~/components/form/Datetime.vue')

@Component({
  components: { ImgCropForm, DatetimeForm },
})
export default class extends mixins(BlockUnloadMixin) {
  @Prop({ type: String, required: true }) readonly submitText: string

  @Prop({ type: String, default: '' }) readonly uid: string
  @PropSync('imgDataURLValue', { type: String, required: true }) imgDataURL!: string
  @PropSync('nameValue', { type: String, required: true }) name!: string
  @PropSync('descriptionValue', { type: String, required: true }) description!: string
  @PropSync('isPublicValue', { type: Boolean, required: true }) isPublic!: boolean

  // group
  @PropSync('groupDisplayNameValue', { type: String || null, default: null }) groupDisplayName!: string | null
  @PropSync('groupIsEditValue', { type: Boolean, required: true }) groupIsEdit!: number
  @PropSync('groupHopeMaxNumValue', { type: Number || null, default: null }) groupHopeMaxNum!: number | null

  // participate user
  @PropSync('participateUserDisplayNameValue', { type: String || null, default: null }) participateUserDisplayName!:
    | string
    | null

  @PropSync('participateUserIsEditValue', { type: Boolean, required: true }) participateUserIsEdit!: number
  @PropSync('participateUserHopeMaxNumValue', { type: Number || null, default: null }) participateUserHopeMaxNum!:
    | number
    | null

  // time
  @PropSync('startAtValue', { type: Date, required: true }) startAt!: Date
  @PropSync('votingEndAtValue', { type: Date, required: true }) votingEndAt!: Date
  @PropSync('browsingEndAtValue', { type: Date, required: true }) browsingEndAt!: Date

  @Prop({ type: Function, required: true }) submitFunc: () => Promise<void>
  @Prop({ type: Function, default: () => {} }) resetFunc: () => Promise<void>

  // form config
  valid = true
  disabled = false
  loading = false
  submitLoading = false
  resetLoading = false
  rules = this.$formRules.room

  // isGroupHopeMaxNum

  isGroupHopeMaxNum = true
  @Watch('isGroupHopeMaxNum')
  changeIsGroupHopeMaxNum(isGroupHopeMaxNum: boolean) {
    if (!isGroupHopeMaxNum) this.groupHopeMaxNum = null
  }

  // isParticipateUserHopeMaxNum

  isParticipateUserHopeMaxNum = true
  @Watch('isParticipateUserHopeMaxNum')
  changeIsParticipateUserHopeMaxNum(isParticipateUserHopeMaxNum: boolean) {
    if (!isParticipateUserHopeMaxNum) this.participateUserHopeMaxNum = null
  }

  // form func

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
      this.$store.dispatch('snackbar/error', '入力に誤りがあります。')
      return
    }
    // 日付チェック
    if (this.startAt.getTime() >= this.votingEndAt.getTime()) {
      this.$store.dispatch('snackbar/error', '希望提出締め切り日時は、開始日時よりも後に設定してください。')
      return
    } else if (this.votingEndAt.getTime() >= this.browsingEndAt.getTime()) {
      this.$store.dispatch('snackbar/error', '閲覧締め切り日時は、希望提出締め切り日時よりも後に設定してください。')
      return
    } else if (this.startAt.getTime() >= this.browsingEndAt.getTime()) {
      this.$store.dispatch('snackbar/error', '閲覧締め切り日時は、開始日時よりも後に設定してください。')
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
