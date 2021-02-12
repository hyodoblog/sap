<template lang="pug">
  div
    v-btn(
      color="primary"
      @click="dialog = true"
    ) 一人追加する
    RoomParticipateUserFormDialog(
      :dialogValue.sync="dialog"
      title="メンバーを追加"
      submitText="追加する"
      :displayNameValue.sync="displayName"
      :emailValue.sync="email"
      :submitFunc="submit"
    )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
const RoomParticipateUserFormDialog = () =>
  import('~/components/pages/rooms/dashboard/participate-user/form/Dialog.vue')

@Component({
  components: { RoomParticipateUserFormDialog },
})
export default class RoomDashboardParticipateUserFormNewComponent extends Vue {
  dialog = false

  // form vars

  displayName = ''
  email = ''

  // form submti

  submit() {
    const roomUid = this.$route.params.uid
    return this.$fire.store.roomParticipateUser
      .setItem(roomUid, {
        displayName: this.displayName,
        email: this.email,
        loginToken: this.$utils.utility.getRandomToken(40),
        hopeGroupUidItems: [],
      })
      .then(() => this.$store.dispatch('snackbar/success', 'メンバーを保存しました。'))
      .catch(() => this.$store.dispatch('snackbar/error', 'メンバーの保存に失敗しました。'))
  }
}
</script>
