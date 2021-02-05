<template lang="pug">
  v-container(fluid)
    v-row
      v-col(cols="12")
        BaseVComponent(title="部屋管理" icon="mdi-monitor-dashboard")

    v-row.mb-6
      v-col(cols="12")
        .d-flex.justify-space-between.align-center
          .title あなたが作成した部屋
          v-btn(
            color="primary"
            :to="$routes.front.sapAppNew"
          ) 部屋を作成する
      v-col(cols="12")
        RoomsTable

    v-row
      v-col(cols="12")
        .d-flex.justify-space-between.align-center
          .title 参加中の部屋
      v-col(cols="12")
        RoomsTable
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
const BaseVComponent = () => import('~/components/base/BaseVComponent.vue')
const RoomsTable = () => import('~/components/pages/rooms/Table.vue')

@Component({
  layout: 'protected',
  components: { BaseVComponent, RoomsTable },
})
export default class RoomsPage extends Vue {}
</script>
