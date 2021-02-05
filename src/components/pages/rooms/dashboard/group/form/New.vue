<template lang="pug">
  div
    v-btn(
      color="primary"
      @click="dialog = true"
    ) グループ追加する
    RoomGroupFormDialog(
      :dialogValue.sync="dialog"
      submitText="追加する"
      :nameValue.sync="name"
      :descriptionValue.sync="description"
      :priorityValue.sync="priority"
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

  name = ''
  description = ''
  priority = 0

  // form submti

  submit() {
    const roomUid = this.$route.params.uid
    return this.$fire.store.roomGroup
      .setItem(roomUid, { name: this.name, description: this.description, priority: this.priority })
      .then(() => this.$store.dispatch('snackbar/success', 'グループを保存しました。'))
      .catch(() => this.$store.dispatch('snackbar/error', 'グループの保存に失敗しました。'))
  }
}
</script>
