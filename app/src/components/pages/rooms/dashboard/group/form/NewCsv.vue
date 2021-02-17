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
    FormDialogCsv: () => import('~/components/pages/rooms/dashboard/form/DialogCsv.vue'),
  },
})
export default class RoomDashboardGroupFormNewCsvComponent extends Vue {
  dialog = false

  isValid = true
  isLoading = false

  // form submti

  submit(csvData: string[][]) {
    const roomUid = this.$route.params.uid
    return Promise.all(
      csvData.map((line) =>
        this.$fire.store.roomGroup.setItem(roomUid, {
          displayName: line[0].replace(/\r?\n/g, ''),
          email: line[1] ? line[1].replace(/\r?\n/g, '') : null,
          description: line[2] ? line[2].replace(/\r?\n/g, '') : null,
          maxNum: line[3] ? Number(line[3].replace(/\r?\n/g, '')) : null,
          loginToken: this.$utils.utility.getRandomToken(40),
          hopeParticipateUserUidItems: [],
        })
      )
    )
      .then(() => {
        this.$store.dispatch('snackbar/success', 'グループを保存しました。')
        const roomUid = this.$route.params.uid
        this.$store.dispatch('room/group/init', roomUid)
      })
      .catch(() => this.$store.dispatch('snackbar/error', 'グループの保存に失敗しました。'))
  }
}
</script>
