<template lang="pug">
  v-container(fluid)
    template(v-if="item")
      v-row
        v-col
          BaseVComponent(:title="`「${item.name}」部屋`" icon="mdi-monitor-dashboard")
        v-col.text-right
          v-btn(
            color="warning"
            elevation="0"
            :to="$routes.front.roomEdit(item.uid)"
          ) 部屋を編集する

      v-row
        v-col.text-right
          RoomsDashboardInvitation

      v-row
        v-col
          RoomsDashboardInfo(:item="item")

      RoomsDashboardGroupList

      RoomsDashboardParticipateUserList

    template(v-else)
      v-overlay
        v-progress-circular(indeterminate size="64")
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { Room } from '~/modules/types/models'
const BaseVComponent = () => import('~/components/base/BaseVComponent.vue')
const RoomsDashboardInvitation = () => import('~/components/pages/rooms/dashboard/btn/Invitation.vue')
const RoomsDashboardInfo = () => import('~/components/pages/rooms/dashboard/Info.vue')
const RoomsDashboardGroupList = () => import('~/components/pages/rooms/dashboard/group/List.vue')
const RoomsDashboardParticipateUserList = () => import('~/components/pages/rooms/dashboard/participate-user/List.vue')

@Component({
  layout: 'protected',
  components: {
    BaseVComponent,
    RoomsDashboardInvitation,
    RoomsDashboardInfo,
    RoomsDashboardGroupList,
    RoomsDashboardParticipateUserList,
  },
})
export default class RoomsDashboardComponent extends Vue {
  async beforeCreate() {
    try {
      const { uid } = this.$route.params
      const item = await this.$fire.store.room.getItem(uid)
      if (item === null) throw Error
      this.item = item
    } catch {
      this.$nuxt.error({
        statusCode: 404,
        message: 'ページが見つかりませんでした。',
      })
    }
  }

  item: Room | null = null
}
</script>
