<template lang="pug">
  v-row.mb-6
    v-col(cols="12")
      .d-flex.justify-space-between.align-center
        .title 参加者一覧
        RoomParticipateUserFormNew
        
    v-col(cols="12")
      RoomParticipateUserTable
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
const RoomParticipateUserFormNew = () => import('~/components/pages/rooms/dashboard/participate-user/form/New.vue')
const RoomParticipateUserTable = () => import('~/components/pages/rooms/dashboard/participate-user/Table.vue')

@Component({
  components: { RoomParticipateUserFormNew, RoomParticipateUserTable },
})
export default class RoomsDashboardParticipateUserList extends Vue {
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
