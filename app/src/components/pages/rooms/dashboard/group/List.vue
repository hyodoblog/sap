<template lang="pug">
  v-row.mb-6
    v-col(cols="12")
      .d-flex.justify-space-between.align-center
        .title グループ一覧（{{ $store.state.room.group.items.length }}）
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
    RoomGroupFormNewCsv: () => import('./form/NewCsv.vue'),
    RoomGroupFormNew: () => import('./form/New.vue'),
    RoomGroupTable: () => import('./Table.vue'),
  },
})
export default class RoomDashboardGroupListConmponent extends Vue {}
</script>
