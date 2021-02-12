<template lang="pug">
  div
    v-btn(
      color="primary"
      @click="dialog = true"
    ) CSVで追加する
    FormDialogCsv(
      :dialogValue.sync="dialog"
      title="グループを追加"
      submitText="追加する"
      :submitFunc="submit"
    )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  components: {
    FormDialogCsv: () => import('~/components/pages/rooms/dashboard/group/form/DialogCsv.vue'),
  },
})
export default class RoomDashboardGroupFormNewCsvComponent extends Vue {
  dialog = false

  isValid = true
  isLoading = false

  // form submti

  submit(csvData: string[][]) {
    const roomUid = this.$route.params.uid
    csvData.shift()
    return Promise.all(
      csvData.map((line) =>
        this.$fire.store.roomGroup.setItem(roomUid, {
          displayName: line[0],
          email: line[1] ? line[1] : null,
          description: line[2] ? line[2] : null,
          maxNum: line[3] ? Number(line[3]) : null,
          loginToken: this.$utils.utility.getRandomToken(40),
          hopeParticipateUserUidItems: [],
        })
      )
    )
      .then(() => this.$store.dispatch('snackbar/success', 'グループを保存しました。'))
      .catch(() => this.$store.dispatch('snackbar/error', 'グループの保存に失敗しました。'))
  }
}
</script>
