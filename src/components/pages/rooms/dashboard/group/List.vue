<template lang="pug">
  v-row.mb-6
    v-col(cols="12")
      .d-flex.justify-space-between.align-center
        .title グループ一覧
        div.d-flex
          RoomGroupFormNewCsv
          RoomGroupFormNew.ml-2

    v-col(cols="12")
      RoomGroupTable
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component({
  components: {
    RoomGroupFormNewCsv: () => import('~/components/pages/rooms/dashboard/group/form/NewCsv.vue'),
    RoomGroupFormNew: () => import('~/components/pages/rooms/dashboard/group/form/New.vue'),
    RoomGroupTable: () => import('~/components/pages/rooms/dashboard/group/Table.vue'),
  },
})
export default class RoomDashboardGroupListConmponent extends Vue {}
</script>
