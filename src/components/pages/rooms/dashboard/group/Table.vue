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
          tr.pointer(@click="editOn(item)")
            td(v-text="item.displayName")
            td(v-text="item.description")
            td(v-text="item.maxNum")
      
    RoomGroupFormDialog(
      :dialogValue.sync="dialog"
      title="グループを編集"
      submitText="編集する"
      :groupUid="groupUid"
      :displayNameValue.sync="displayName"
      :descriptionValue.sync="description"
      :maxNumValue.sync="maxNum"
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
      text: '最大参加人数',
      value: 'maxNum',
    },
  ]

  // edit form

  dialog = false
  groupUid = ''
  displayName = ''
  description = ''
  maxNum = 0

  editOn(item: RoomGroup) {
    this.groupUid = item.uid as string
    this.displayName = item.displayName
    this.description = item.description === null ? '' : this.description
    this.maxNum = item.maxNum === null ? 0 : this.maxNum
    this.dialog = true
  }

  editSubmit() {
    const roomUid = this.$route.params.uid
    return this.$fire.store.roomGroup
      .updateItem(roomUid, this.groupUid, {
        displayName: this.displayName,
        description: this.description ? this.description : null,
        maxNum: this.maxNum > 0 ? this.maxNum : null,
        loginToken: this.$utils.utility.getRandomToken(30),
        hopeParticipateUserUidItems: [],
      })
      .then(() => this.$store.dispatch('snackbar/success', 'グループを編集しました。'))
      .catch(() => this.$store.dispatch('snackbar/error', 'グループの編集に失敗しました。'))
  }
}
</script>
