<template lang="pug">
  div
    v-btn(
      color="primary"
      @click="dialog = true"
    ) グループ追加する
    RoomGroupFormDialog(
      :dialogValue.sync="dialog"
      title="グループを追加"
      submitText="追加する"
      :displayNameValue.sync="displayName"
      :descriptionValue.sync="description"
      :maxNumValue.sync="maxNum"
      :submitFunc="submit"
    )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
const RoomGroupFormDialog = () => import('~/components/pages/rooms/dashboard/group/form/Dialog.vue')

@Component({
  components: { RoomGroupFormDialog },
})
export default class RoomsDashboardGroupFormNewComponent extends Vue {
  dialog = false

  // form vars

  displayName = ''
  description = ''
  maxNum = 0

  // form submti

  submit() {
    const roomUid = this.$route.params.uid
    return this.$fire.store.roomGroup
      .setItem(roomUid, {
        displayName: this.displayName,
        description: this.description ? this.description : null,
        maxNum: this.maxNum > 0 ? this.maxNum : null,
        loginToken: this.$utils.utility.getRandomToken(40),
        hopeParticipateUserUidItems: [],
      })
      .then(() => this.$store.dispatch('snackbar/success', 'グループを保存しました。'))
      .catch(() => this.$store.dispatch('snackbar/error', 'グループの保存に失敗しました。'))
  }
}
</script>
