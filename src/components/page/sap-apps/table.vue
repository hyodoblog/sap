<template lang="pug">
  client-only
    v-data-table(
      :headers="headers"
      :items="items"
      :search.sync="search"
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
          td
            v-avatar.logo-mini
              v-img(:src="$utils.url.getImgUrl(item.iconPath)")
          td(v-text="item.name")
          td(v-text="item.description")
          td(v-text="$fire.getConvertTimeJa(item.startAt)")
          td(v-text="$fire.getConvertTimeJa(item.votingEndAt)")
          td(v-text="$fire.getConvertTimeJa(item.browsingEndAt)")
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
const BaseMaterialCard = () => import('~/components/base/BaseMaterialCard.vue')

@Component({
  components: { BaseMaterialCard },
})
export default class SapAppsTable extends Vue {
  search = ''

  headers = [
    {
      text: '',
      value: 'iconPath',
      sortable: false,
    },
    {
      text: '名前',
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
      text: '投票終了日時',
      value: 'votingEndAt',
    },
    {
      text: '閲覧可能日時',
      value: 'browsingEndAt',
    },
  ]

  get items() {
    return []
  }

  movePage(userUid: string) {
    this.$router.push(`/sap-apps/${userUid}`)
  }
}
</script>
