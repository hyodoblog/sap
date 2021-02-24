<template lang="pug">
  v-container(fluid)
    //- loading
    v-overlay(v-if="loadingPage")
      v-progress-circular(indeterminate size="64")

    template(v-else)
      BtnPageBack(:link="$routes.front.roomDashboard(roomItem.uid)")

      v-row
        v-col
          BaseVComponent(:title="`「${roomItem.name}」部屋の投票状況`" icon="mdi-monitor-dashboard")

      v-row
        v-col
          .title.mb-2 {{ groupDisplayName }}の投票一覧
          v-simple-table
            template(v-slot:default)
              thead
                tr
                  th {{ groupDisplayName }}
                  th {{ participateUserDisplayName }}
              tbody
                tr(v-for="item in roomGroupItems")
                  td {{ item.displayName }}
                  td {{ getHopeParticipateUserUidItems(item.hopeParticipateUserUidItems) }}

        v-col
          .title.mb-2 {{ participateUserDisplayName }}の投票一覧
          v-simple-table
            template(v-slot:default)
              thead
                tr
                  th {{ groupDisplayName }}
                  th {{ participateUserDisplayName }}
              tbody
                tr(v-for="item in roomParticipateUserItems")
                  td {{ item.displayName }}
                  td {{ getHopeGroupUidItems(item.hopeGroupUidItems) }}
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { Room, RoomGroup, RoomParticipateUser } from '~/modules/types/models'

@Component({
  layout: 'protected',
  components: {
    BaseVComponent: () => import('~/components/base/BaseVComponent.vue'),
    BtnPageBack: () => import('~/components/btn/PageBack.vue'),
  },
})
export default class RoomDashboardVotingPage extends Vue {
  async beforeMount() {
    try {
      const { uid } = this.$route.params
      const roomItem = await this.$fire.store.room.getItem(uid)
      const roomGroupItems = await this.$fire.store.roomGroup.getItems(uid)
      const roomParticipateUserItems = await this.$fire.store.roomParticipateUser.getItems(uid)
      this.roomItem = roomItem
      this.roomGroupItems = roomGroupItems
      this.roomParticipateUserItems = roomParticipateUserItems
    } catch {
      return this.$nuxt.error({
        statusCode: 404,
        message: 'ページが見つかりませんでした。',
      })
    }
  }

  roomItem: Room | null = null
  roomGroupItems: RoomGroup[] | null = null
  roomParticipateUserItems: RoomParticipateUser[] | null = null

  get loadingPage(): boolean {
    return this.roomItem === null || this.roomGroupItems === null || this.roomParticipateUserItems === null
  }

  // table header

  get groupDisplayName(): string | null {
    return (this.roomItem as Room).groupDisplayName || 'グループ'
  }

  get participateUserDisplayName(): string | null {
    return (this.roomItem as Room).participateUserDisplayName || '参加者'
  }

  getHopeParticipateUserUidItems(participateUserUidItems: string[]): string {
    let dispalyName = ''
    participateUserUidItems.forEach((uid) => {
      const participateUserItem = this.roomParticipateUserItems?.filter((item) => item.uid === uid)
      dispalyName += `${
        participateUserItem && participateUserUidItems.length > 0
          ? participateUserItem[0].displayName
          : `削除済み${this.participateUserDisplayName}`
      }  `
    })
    return dispalyName
  }

  getHopeGroupUidItems(groupUidItems: string[]): string {
    let dispalyName = ''
    groupUidItems.forEach((uid) => {
      const groupItems = this.roomGroupItems?.filter((item) => item.uid === uid)
      dispalyName += `${
        groupItems && groupItems.length > 0 ? groupItems[0].displayName : `削除済み${this.groupDisplayName}`
      }  `
    })
    return dispalyName
  }
}
</script>
