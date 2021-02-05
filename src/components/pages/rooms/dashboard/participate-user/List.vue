<template lang="pug">
  v-row
    v-col(cols="12")
      .d-flex.justify-space-between.align-center
        .title 参加メンバー一覧
        
    v-col(cols="12")
      RoomParticipateUserTable
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component
export default class RoomsDashboardParticipateUserList extends Vue {
  dialog = false
}
</script>
