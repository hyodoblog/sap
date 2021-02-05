<template lang="pug">
  v-container(fluid)
    v-row
      v-col(cols="12")
        BaseVComponent(:title="`${item.name}部屋`" icon="mdi-monitor-dashboard")

    v-row.mb-6
      v-col(cols="12")
        .d-flex.justify-space-between.align-center
          .title グループ一覧
          v-btn(
            color="primary"
            :to="$routes.front.roomNew"
          ) グループを作成する
      v-col(cols="12")
        RoomGroupTable

    v-row
      v-col(cols="12")
        .d-flex.justify-space-between.align-center
          .title 参加メンバー一覧
      v-col(cols="12")
        RoomParticipateUserTable
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { Room } from '~/modules/types/models'
const BaseVComponent = () => import('~/components/base/BaseVComponent.vue')
const RoomGroupTable = () => import('~/components/pages/rooms/GroupTable.vue')
const RoomParticipateUserTable = () => import('~/components/pages/rooms/ParticipateUserTable.vue')

@Component({
  layout: 'protected',
  components: { BaseVComponent, RoomGroupTable, RoomParticipateUserTable },
  async asyncData({ app, error, route }) {
    try {
      const { uid } = route.params
      const item = await app.$fire.store.room.getItem(uid)
      if (item === null) throw Error
      return {
        item,
      }
    } catch {
      error({
        statusCode: 404,
        message: 'ページが見つかりませんでした。',
      })
    }
  },
})
export default class RoomDashboardComponent extends Vue {
  item: Room
}
</script>
