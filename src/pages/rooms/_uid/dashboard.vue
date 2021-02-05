<template lang="pug">
  v-container(fluid)
    v-row
      v-col(cols="12")
        BaseVComponent(:title="`${item.name}部屋`" icon="mdi-monitor-dashboard")

    RoomsDashboardGroupList

    RoomsDashboardParticipateUserList
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { Room } from '~/modules/types/models'
const BaseVComponent = () => import('~/components/base/BaseVComponent.vue')
const RoomsDashboardGroupList = () => import('~/components/pages/rooms/dashboard/group/List.vue')
const RoomsDashboardParticipateUserList = () => import('~/components/pages/rooms/dashboard/participate-user/List.vue')

@Component({
  layout: 'protected',
  components: {
    BaseVComponent,
    RoomsDashboardGroupList,
    RoomsDashboardParticipateUserList,
  },
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
export default class RoomsDashboardComponent extends Vue {
  item: Room
}
</script>
