<template lang="pug">
  v-container.px-2(fluid)
    //- loading
    v-overlay(v-if="loadingPage")
      v-progress-circular(indeterminate size="64")

    template(v-else)
      .title マッチングページ

      v-simple-table(dense)
        template(v-slot:default)
          thead
            tr
              th {{ groupDisplayName }}
              th {{ participateUserDisplayName }}
          tbody
            tr(v-for="item in items")
              td {{ getGroupDispalyName(item.groupUid) }}
              td {{ getParticipateUserDisplayNameItems(item.participateUserUidItems) }}
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { RoomGroup, RoomParticipateUser, RoomMatching } from '~/modules/types/models'

@Component({
  layout: 'public',
})
export default class RoomMatchingPage extends Vue {
  async mounted() {
    try {
      const roomUid = this.$route.params.uid
      const items = await this.$fire.store.roomMatching.getItems(roomUid)
      this.items = items
    } catch {
      this.$nuxt.error({
        statusCode: 404,
      })
    }
  }

  items: RoomMatching[] | null = null

  get roomUid(): string {
    return this.$route.params.uid
  }

  get roomGroupItems(): RoomGroup[] | null {
    return this.$store.state.invitation.roomGroupItems
  }

  get roomParticipateUserItems(): RoomParticipateUser[] | null {
    return this.$store.state.invitation.roomParticipateUserItems
  }

  get loadingPage(): boolean {
    return this.items === null || this.roomGroupItems === null || this.roomParticipateUserItems === null
  }

  // table

  get groupDisplayName(): string | null {
    return this.$store.state.invitation.roomItem?.groupDisplayName
  }

  get participateUserDisplayName(): string | null {
    return this.$store.state.invitation.roomItem?.participateUserDisplayName
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
