<template lang="pug">
  v-container(fluid)
    template(v-if="item")
      BtnPageBack(:link="$routes.front.roomDashboard(item.uid)")

      v-row
        v-col
          BaseVComponent(:title="`「${item.name}」部屋の投票状況`" icon="mdi-monitor-dashboard")

      v-row
        v-col.text-right
          RoomDashboardInvitation

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
    RoomDashboardWarning: () => import('~/components/pages/rooms/dashboard/Warning.vue'),
  },
})
export default class RoomDashboardVotingPage extends Vue {
  async beforeMount() {
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
