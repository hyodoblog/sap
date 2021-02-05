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
          tr.pointer
            td(v-text="item.displayName")
            td(v-text="item.email")

    RoomParticipateUserFormDialog(
      :dialogValue.sync="dialog"
      submitText="編集する"
      :displayNameValue.sync="displayName"
      :emailValue.sync="email"
      :submitFunc="editSubmit"
    )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { RoomParticipateUser } from '~/modules/types/models'
const BaseMaterialCard = () => import('~/components/base/BaseMaterialCard.vue')
const RoomParticipateUserFormDialog = () =>
  import('~/components/pages/rooms/dashboard/participate-user/form/Dialog.vue')

@Component({
  components: { BaseMaterialCard, RoomParticipateUserFormDialog },
})
export default class RoomsDashboardParticipateUserTableComponent extends Vue {
  async mounted() {
    if (this.items.length === 0) {
      this.loading = true
      const roomUid = this.$route.params.uid
      await this.$store.dispatch('room/participate-user/init', roomUid)
      this.loading = false
    }
  }

  get items(): RoomParticipateUser[] {
    return this.$store.state.room['participate-user'].items
  }

  search = ''
  loading = false

  headers = [
    {
      text: '名前',
      value: 'name',
    },
    {
      text: 'メールアドレス',
      value: 'email',
    },
  ]

  // edit form

  dialog = false
  groupUid = ''
  displayName = ''
  email = ''
  priority = 0

  editOn(item: RoomParticipateUser) {
    this.groupUid = item.uid as string
    this.displayName = item.displayName
    this.email = item.email
    this.dialog = true
  }

  editSubmit() {
    const roomUid = this.$route.params.uid
    return this.$fire.store.roomParticipateUser
      .updateItem(roomUid, this.groupUid, { displayName: this.displayName, email: this.email } as RoomParticipateUser)
      .then(() => this.$store.dispatch('snackbar/success', '参加メンバーを編集しました。'))
      .catch(() => this.$store.dispatch('snackbar/error', '参加メンバーの編集に失敗しました。'))
  }
}
</script>
