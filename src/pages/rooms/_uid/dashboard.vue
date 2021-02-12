<template lang="pug">
  v-container(fluid)
    template(v-if="item")
      BtnPageBack(:link="$routes.front.rooms")

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
          RoomDashboardInvitation

      v-row
        v-col
          RoomDashboardInfo(:item="item")

      RoomDashboardGroupList

      RoomDashboardParticipateUserList

    v-overlay(v-else)
      v-progress-circular(indeterminate size="64")
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { Room } from '~/modules/types/models'

@Component({
  layout: 'protected',
  components: {
    BaseVComponent: () => import('~/components/base/BaseVComponent.vue'),
    BtnPageBack: () => import('~/components/btn/PageBack.vue'),
    RoomDashboardInvitation: () => import('~/components/pages/rooms/dashboard/btn/Invitation.vue'),
    RoomDashboardInfo: () => import('~/components/pages/rooms/dashboard/Info.vue'),
    RoomDashboardGroupList: () => import('~/components/pages/rooms/dashboard/group/List.vue'),
    RoomDashboardParticipateUserList: () => import('~/components/pages/rooms/dashboard/participate-user/List.vue'),
  },
})
export default class RoomDashboardComponent extends Vue {
  async mounted() {
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
