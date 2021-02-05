<template lang="pug">
  v-row.mb-6
    v-col(cols="12")
      .d-flex.justify-space-between.align-center
        .title グループ一覧
        RoomGroupFormNew

    v-col(cols="12")
      RoomGroupTable
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
const RoomGroupFormNew = () => import('~/components/pages/rooms/dashboard/group/form/New.vue')
const RoomGroupTable = () => import('~/components/pages/rooms/dashboard/group/Table.vue')

@Component({
  components: { RoomGroupFormNew, RoomGroupTable },
})
export default class RoomsDashboardGroupListConmponent extends Vue {}
</script>
