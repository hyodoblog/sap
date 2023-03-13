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
          tr
            td(v-text="item.displayName")
            td(v-text="item.email")
            td(v-text="item.description" style="max-width: 180px;word-break: break-all;")
            td(v-text="item.maxNum")
            td(v-text="item.rateNum || ''")
            td.text-right
              v-tooltip(v-if="!!item.email" bottom)
                template(v-slot:activator="{ attrs, on }")
                  v-btn.mx-1(
                    v-bind="attrs"
                    light
                    icon
                    v-on="on"
                    :loading="loadingMailUid === item.uid"
                    @click="sendMail(item)"
                  )
                    v-icon.info--text mdi-email
                span 招待メールを送信
              v-tooltip(bottom)
                template(v-slot:activator="{ attrs, on }")
                  v-btn.mx-1(
                    v-bind="attrs"
                    light
                    icon
                    v-on="on"
                    @click="editOn(item)"
                  )
                    v-icon.success--text mdi-pencil
                span 編集
              v-tooltip(bottom)
                template(v-slot:activator="{ attrs, on }")
                  v-btn.mx-1(
                    v-bind="attrs"
                    light
                    icon
                    v-on="on"
                    @click="remove(item)"
                  )
                    v-icon.error--text mdi-delete
                span 削除
      
    RoomGroupFormDialog(
      :dialogValue.sync="dialog"
      title="グループを編集"
      submitText="編集する"
      :groupUid="groupUid"
      :displayNameValue.sync="displayName"
      :emailValue.sync="email"
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
export default class RoomDashboardGroupTableComponent extends Vue {
  async beforeMount() {
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
      text: '表示名',
      value: 'name',
    },
    {
      text: 'メールアドレス',
      value: 'email',
    },
    {
      text: '詳細',
      value: 'description',
    },
    {
      text: '最大参加人数',
      value: 'maxNum',
    },
    {
      text: 'レート',
      value: 'rateNum',
    },
    {
      sortable: false,
      text: '',
      value: '',
    },
  ]

  // send mail

  loadingMailUid: string | null = null

  async sendMail(item: RoomGroup) {
    try {
      this.loadingMailUid = item.uid as string
      const roomUid = this.$route.params.uid
      const headers = await this.$fire.auth.getAuthHeaders()
      await this.$api.back.groupInvitation({ roomUid, groupUid: item.uid as string }, headers)
      this.$store.dispatch('snackbar/success', `${item.displayName}さんへ招待メールを送りました。`)
    } catch {
      this.$store.dispatch('snackbar/error', `${item.displayName}さんへ招待メールの送信に失敗しました。`)
    } finally {
      this.loadingMailUid = null
    }
  }

  // edit form

  dialog = false
  groupUid = ''
  displayName = ''
  email = ''
  description = ''
  maxNum: number | null = null

  editOn(item: RoomGroup) {
    this.groupUid = item.uid as string
    this.displayName = item.displayName
    this.description = item.description === null ? '' : item.description
    this.email = item.email === null ? '' : item.email
    this.maxNum = item.maxNum
    this.dialog = true
  }

  editSubmit() {
    const roomUid = this.$route.params.uid
    return this.$fire.store.roomGroup
      .updateItem(roomUid, this.groupUid, {
        displayName: this.displayName,
        description: this.description ? this.description : null,
        email: this.email ? this.email : null,
        maxNum: this.maxNum,
        loginToken: this.$utils.utility.getRandomToken(30),
      } as RoomGroup)
      .then(() => this.$store.dispatch('snackbar/success', 'グループを編集しました'))
      .catch(() => this.$store.dispatch('snackbar/error', 'グループの編集に失敗しました'))
  }

  // remove form

  async remove(item: RoomGroup) {
    try {
      const roomUid = this.$route.params.uid
      await this.$fire.store.roomGroup.deleteItem(roomUid, item.uid as string)
      this.$store.dispatch('room/group/init', roomUid)
      this.$store.dispatch('snackbar/success', `「${item.displayName}」を削除しました。`)
    } catch {
      this.$store.dispatch('snackbar/error', `「${item.displayName}」の削除に失敗しました。`)
    }
  }
}
</script>
