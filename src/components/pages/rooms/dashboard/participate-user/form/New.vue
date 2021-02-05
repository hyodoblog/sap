<template lang="pug">
  div
    v-btn(
      color="primary"
      @click="dialog = true"
    ) メンバーを追加する
    RoomParticipateUserFormDialog(
      :dialogValue.sync="dialog"
      submitText="追加する"
      :nameValue.sync="name"
      :emailValue.sync="email"
      :submitFunc="submit"
    )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
const RoomParticipateUserFormDialog = () => import('~/components/pages/rooms/dashboard/participate-user/form/Dialog.vue')

@Component({
  components: { RoomParticipateUserFormDialog },
})
export default class RoomsDashboardParticipateUserFormNewComponent extends Vue {
  dialog = false

  // form vars

  name = ''
  email = ''

  // form submti

  submit() {}
}
</script>
