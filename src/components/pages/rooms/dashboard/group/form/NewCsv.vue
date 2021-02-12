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

  submit() {
    // const roomUid = this.$route.params.uid
    // return this.$fire.store.roomGroup
    //   .setItem(roomUid, {
    //     displayName: this.displayName,
    //     email: this.email ? this.email : null,
    //     description: this.description ? this.description : null,
    //     maxNum: this.maxNum > 0 ? this.maxNum : null,
    //     loginToken: this.$utils.utility.getRandomToken(40),
    //     hopeParticipateUserUidItems: [],
    //   })
    //   .then(() => this.$store.dispatch('snackbar/success', 'グループを保存しました。'))
    //   .catch(() => this.$store.dispatch('snackbar/error', 'グループの保存に失敗しました。'))
  }
}
</script>
