<template lang="pug">
  div
    v-btn(
      color="primary"
      @click="dialog = true"
    ) CSVで追加する
    FormDialogCsv(
      :dialogValue.sync="dialog"
      title="参加者一括で追加"
      submitText="追加する"
      :submitFunc="submit"
    )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  components: {
    FormDialogCsv: () => import('~/components/pages/rooms/dashboard/form/DialogCsv.vue'),
  },
})
export default class RoomDashboardParticipateUserFormNewCsvComponent extends Vue {
  dialog = false

  isValid = true
  isLoading = false

  // form submti

  submit(csvData: string[][]) {
    const roomUid = this.$route.params.uid
    csvData.shift()
    return Promise.all(
      csvData.map((line) =>
        this.$fire.store.roomParticipateUser.setItem(roomUid, {
          displayName: line[0],
          email: line[1],
          loginToken: this.$utils.utility.getRandomToken(40),
          hopeGroupUidItems: [],
        })
      )
    )
      .then(() => {
        this.$store.dispatch('snackbar/success', '参加者を一括保存しました。')
        const roomUid = this.$route.params.uid
        this.$store.dispatch('room/participate-user/init', roomUid)
      })
      .catch(() => this.$store.dispatch('snackbar/error', '参加者の一括保存に失敗しました。'))
  }
}
</script>
