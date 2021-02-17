<template lang="pug">
  v-row.mb-6
    v-col(cols="12")
      .d-flex.justify-space-between.align-center
        .title 参加者一覧
        .d-flex
          RoomParticipateUserFormNewCsv
          RoomParticipateUserFormNew.ml-2
        
    v-col(cols="12")
      RoomParticipateUserTable
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  components: {
    RoomParticipateUserFormNewCsv: () => import('./form/NewCsv.vue'),
    RoomParticipateUserFormNew: () => import('./form/New.vue'),
    RoomParticipateUserTable: () => import('./Table.vue'),
  },
})
export default class RoomDashboardParticipateUserList extends Vue {
  // new form

  dialog = false

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
