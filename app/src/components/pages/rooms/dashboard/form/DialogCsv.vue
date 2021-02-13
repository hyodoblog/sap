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

        template(v-if="!!csvData")
          .title.mb-2 追加するデータ： {{ csvData.length }}

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
import encoding, { Encoding } from 'encoding-japanese'

@Component
export default class RoomDashboardFormDialogCsvComponent extends Vue {
  @PropSync('dialogValue', { type: Boolean, required: true }) dialog!: boolean

  @Prop({ type: String, required: true }) readonly title: string
  @Prop({ type: String, required: true }) readonly submitText: string
  @Prop({ type: Function, required: true }) submitFunc: (csvData: string[][]) => Promise<void>

  isValid = true
  isLoading = false

  file: File | null = null

  csvData: string[][] | null = null

  async changeFile(file: File | null) {
    try {
      if (file !== null) {
        const csvData = await this.getLinesToCsv(file)
        if (!this.isCheckData(csvData)) throw new Error('バリデーションエラー')

        this.csvData = csvData
      }
    } catch (err) {
      if (err === 'バリデーションエラー') this.$store.dispatch('snackbar/error', '入力されたデータに誤りがあります。')
      else this.$store.dispatch('snackbar/error', '正しい形式のCSVファイルを入力してください。')
    }
  }

  getLinesToCsv(file: File): Promise<string[][]> {
    /* eslint prefer-promise-reject-errors: 0 */
    return new Promise((resolve, reject) => {
      const reader = new FileReader()
      reader.onload = () => {
        let result = reader.result
        if (result === null) reject('空データです。')

        const sjisArray = this.$utils.utility.str2Array(result as string)

        const uniArray = encoding.convert(sjisArray, 'UNICODE', encoding.detect(sjisArray) as Encoding)
        result = encoding.codeToString(uniArray)
        const lines = result.split('\n')
        const csvData = lines.map((line) => line.split(','))
        resolve(csvData)
      }
      reader.onerror = (err) => reject(err)
      reader.readAsBinaryString(file)
    })
  }

  isCheckData(csvData: string[][]): boolean {
    // group
    if (csvData[0].length === 4) {
      for (let i = 1; i < csvData.length; i++) {
        if (csvData[i].length !== 4) continue
        if (this.$formRules.roomGroup.displayName.some((rule) => typeof rule(csvData[i][0]) === 'string')) return false
        else if (this.$formRules.roomGroup.email.some((rule) => typeof rule(csvData[i][1]) === 'string')) return false
        else if (this.$formRules.roomGroup.description.some((rule) => typeof rule(csvData[i][2]) === 'string'))
          return false
        else if (this.$formRules.roomGroup.maxNum.some((rule) => typeof rule(csvData[i][3]) === 'string')) return false
      }
    }
    // participateUser
    else if (csvData[0].length === 2) {
      for (let i = 1; i < csvData.length; i++) {
        if (csvData[i].length !== 2) continue
        if (this.$formRules.roomPaticipateUser.displayName.some((rule) => typeof rule(csvData[i][0]) === 'string'))
          return false
        else if (this.$formRules.roomPaticipateUser.email.some((rule) => typeof rule(csvData[i][1]) === 'string'))
          return false
      }
    } else return false
    return true
  }

  submit() {
    // @ts-ignore
    if (this.csvData === null) {
      this.$store.dispatch('snackbar/error', '入力に誤りがあります。')
      return
    }

    this.isValid = false
    this.isLoading = true

    return this.submitFunc(this.csvData).finally(() => {
      this.isValid = true
      this.isLoading = false
      this.dialog = false
      // reset
    })
  }
}
</script>
