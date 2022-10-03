<template lang="pug">
  v-container(fluid)
    //- loading
    v-overlay(v-if="loadingPage")
      v-progress-circular(indeterminate size="64")
  
    template(v-else)
      BtnPageBack(:link="$routes.front.roomDashboard(item.uid)")

      v-row(align="center")
        v-col
          .d-flex.justify-space-between.align-center
            BaseVComponent(:title="`「${item.name}」部屋のマッチング状況`" icon="mdi-monitor-dashboard")
            .caption(v-if="matchingItems.length > 0") 最終更新日時：{{ $fire.store.getConvertDatetimeJa(matchingItems[0].updatedAt) }}

      v-row
        v-col(cols="12")
          v-simple-table
            template(v-slot:default)
              thead
                tr
                  th {{ groupDisplayName }}
                  th {{ participateUserDisplayName }}
              tbody
                tr(v-for="matchingItem in matchingItems")
                  td {{ getGroupDispalyName(matchingItem.groupUid) }}
                  td {{ getParticipateUserDisplayNameItems(matchingItem.participateUserUidItems) }}
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { Room, RoomMatching, RoomGroup, RoomParticipateUser } from '~/modules/types/models'

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
export default class RoomDashboardMatchingPage extends Vue {
  async beforeMount() {
    try {
      const { uid } = this.$route.params
      const [item, matchingItems, roomGroupItems, roomParticipateUserItems] = await Promise.all([
        this.$fire.store.room.getItem(uid),
        this.$fire.store.roomMatching.getItems(uid),
        this.$fire.store.roomGroup.getItems(uid),
        this.$fire.store.roomParticipateUser.getItems(uid),
      ])
      this.item = item
      this.matchingItems = matchingItems
      this.roomGroupItems = roomGroupItems
      this.roomParticipateUserItems = roomParticipateUserItems
    } catch {
      this.$nuxt.error({
        statusCode: 404,
        message: 'ページが見つかりませんでした。',
      })
    }
  }

  item: Room | null = null
  matchingItems: RoomMatching[] | null = null
  roomGroupItems: RoomGroup[] | null = null
  roomParticipateUserItems: RoomParticipateUser[] | null = null

  get loadingPage(): boolean {
    return !this.item || !this.matchingItems || !this.roomGroupItems || !this.roomParticipateUserItems
  }

  // table

  get groupDisplayName(): string | null {
    return (this.item as Room).groupDisplayName
  }

  get participateUserDisplayName(): string | null {
    return (this.item as Room).participateUserDisplayName
  }

  getGroupDispalyName(groupUid: string): string {
    return this.roomGroupItems?.filter((item) => item.uid === groupUid)[0]?.displayName as string
  }

  getParticipateUserDisplayNameItems(participateUserUidItems: string[]): string {
    let dispalyName = ''
    participateUserUidItems.forEach((uid) => {
      dispalyName += `${this.roomParticipateUserItems?.filter((item) => item.uid === uid)[0]?.displayName} `
    })
    return dispalyName
  }
}
</script>
