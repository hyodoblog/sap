<template lang="pug">
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
        tr(@click="movePage(item.uid)" style="cursor: pointer")
          td(v-text="item.name")
          td(v-text="item.description")
          td(v-text="$fire.store.getConvertTimeJa(item.startAt)")
          td(v-text="$fire.store.getConvertTimeJa(item.votingEndAt)")
          td(v-text="$fire.store.getConvertTimeJa(item.browsingEndAt)")
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'nuxt-property-decorator'
import { Room } from '~/modules/types/models'

@Component
export default class RoomsTable extends Vue {
  @Prop({ type: Boolean, required: true }) readonly loading: boolean
  @Prop({ type: Array, required: true }) readonly items: Room[]

  search = ''

  headers = [
    {
      text: '表示名',
      value: 'name',
    },
    {
      text: '詳細',
      value: 'description',
    },
    {
      text: '開始日時',
      value: 'startAt',
    },
    {
      text: '希望提出終了日時',
      value: 'votingEndAt',
    },
    {
      text: '閲覧可能日時',
      value: 'browsingEndAt',
    },
  ]

  movePage(roomUid: string) {
    this.$router.push(this.$routes.front.roomDashboard(roomUid))
  }
}
</script>
