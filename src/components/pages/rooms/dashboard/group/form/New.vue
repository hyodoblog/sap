<template lang="pug">
  div
    v-btn(
      color="primary"
      @click="dialog = true"
    ) 一つ追加する
    RoomGroupFormDialog(
      :dialogValue.sync="dialog"
      title="グループを追加"
      submitText="追加する"
      :displayNameValue.sync="displayName"
      :emailValue.sync="email"
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
export default class RoomDashboardGroupFormNewComponent extends Vue {
  dialog = false

  // form vars

  displayName = ''
  email = ''
  description = ''
  maxNum = 0

  // form submti

  submit() {
    const roomUid = this.$route.params.uid
    return this.$fire.store.roomGroup
      .setItem(roomUid, {
        displayName: this.displayName,
        email: this.email ? this.email : null,
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
