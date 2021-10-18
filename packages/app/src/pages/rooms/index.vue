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
            :to="$routes.front.roomNew"
          ) 部屋を作成する
      v-col(cols="12")
        RoomsTable(
          :loading="roomLoading"
          :items="roomItems"
        )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { Room } from '~/modules/types/models'

@Component({
  layout: 'protected',
  components: {
    BaseVComponent: () => import('~/components/base/BaseVComponent.vue'),
    RoomsTable: () => import('~/components/pages/rooms/Table.vue'),
  },
})
export default class RoomsPage extends Vue {
  async beforeMount() {
    this.roomLoading = this.participateLoading = true
    if (this.roomItems.length === 0) await this.$store.dispatch('room/init')
    this.roomLoading = this.participateLoading = false
  }

  roomLoading = false
  participateLoading = false

  get roomItems(): Room[] {
    return this.$store.state.room.items
  }
}
</script>
