<template lang="pug">
  div
    client-only
      v-data-table(
        :headers="headers"
        :items="items"
        :search.sync="search"
        :loading="loading"
        loading-text="ローディング中"
      )
        template(v-slot:top)
          v-col.d-flex.justify-end
            v-text-field.ml-auto(
              v-model="search"
              append-icon="mdi-magnify"
              label="検索"
              dense
              hide-details
              single-line
              style="max-width: 250px"
            )
        template(v-slot:item="{ item }")
          tr(class="pointer" @click="editOn(item)")
            td(v-text="item.name")
            td(v-text="item.description")
            td(v-text="item.priority")
      
    RoomGroupFormDialog(
      :dialogValue.sync="dialog"
      submitText="編集する"
      :nameValue.sync="name"
      :descriptionValue.sync="description"
      :priorityValue.sync="priority"
      :submitFunc="editSubmit"
    )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { RoomGroup } from '~/modules/types/models'
const BaseMaterialCard = () => import('~/components/base/BaseMaterialCard.vue')
const RoomGroupFormDialog = () => import('~/components/pages/rooms/dashboard/group/form/Dialog.vue')

@Component({
  components: { BaseMaterialCard, RoomGroupFormDialog },
})
export default class RoomsDashboardGroupTableComponent extends Vue {
  async mounted() {
    if (this.items.length === 0) {
      this.loading = true
      const roomUid = this.$route.params.uid
      await this.$store.dispatch('room/group/init', roomUid)
      this.loading = false
    }
  }

  get items(): RoomGroup[] {
    return this.$store.state.room.group.items
  }

  search = ''
  loading = false

  headers = [
    {
      text: '名前',
      value: 'name',
    },
    {
      text: '詳細',
      value: 'description',
    },
    {
      text: '優先度',
      value: 'priority',
    },
  ]

  // edit form

  dialog = false
  groupUid = ''
  name = ''
  description = ''
  priority = 0

  editOn(item: RoomGroup) {
    this.groupUid = item.uid as string
    this.name = item.name
    this.description = item.description
    this.priority = item.priority
    this.dialog = true
  }

  editSubmit() {
    const roomUid = this.$route.params.uid
    return this.$fire.store.roomGroup
      .updateItem(roomUid, this.groupUid, { name: this.name, description: this.description, priority: this.priority })
      .then(() => this.$store.dispatch('snackbar/success', 'グループを編集しました。'))
      .catch(() => this.$store.dispatch('snackbar/error', 'グループの編集に失敗しました。'))
  }
}
</script>
