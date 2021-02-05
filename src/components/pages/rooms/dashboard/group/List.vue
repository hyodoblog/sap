<template lang="pug">
  v-row.mb-6
    v-col(cols="12")
      .d-flex.justify-space-between.align-center
        .title グループ一覧
        RoomsDashboardGroup
        
    v-col(cols="12")
      RoomGroupTable

    RoomGroupDialogForm(
      :dialogValue.sync="newDialog"
      submitText="作成する"
      :submitFunc="newSubmit"
    )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
const RoomGroupDialogForm = () => import('~/components/pages/rooms/dashboard/group/form/Dialog.vue')
const RoomGroupTable = () => import('~/components/pages/rooms/dashboard/group/Table.vue')

@Component({
  components: { RoomGroupDialogForm, RoomGroupTable },
})
export default class RoomsDashboardGroupList extends Vue {
  // new form

  newDialog = false

  newSubmit() {
    try {
      this.$store.dispatch('snackbar/error', 'グループを作成しました。')
    } catch {
      this.$store.dispatch('snackbar/error', 'グループの作成に失敗しました。')
    }
  }

  // edit form
  editDialog = false
}
</script>
