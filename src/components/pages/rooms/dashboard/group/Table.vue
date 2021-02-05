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
        tr(@click="editOn(item)")
          td
            v-avatar.logo-mini
              v-img(:src="$utils.url.getImgUrl(item.iconPath)")
          td(v-text="item.name")
          td(v-text="item.description")
    
      RoomGroupDialogForm(
        :dialogValue.sync="dialog"
        submitText="編集する"
        :nameValue.sync="name"
        :descriptionValue.sync="description"
        :submitFunc="editSubmit"
      )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { RoomGroup } from '~/modules/types/models'
const BaseMaterialCard = () => import('~/components/base/BaseMaterialCard.vue')

@Component({
  components: { BaseMaterialCard },
})
export default class RoomsDashboardGroupTableComponent extends Vue {
  async mounted() {
    if (this.items.length === 0) {
      this.loading = true
      await this.$store.dispatch('room/group/init')
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
  ]

  // edit form

  dialog = false
  name = ''
  description = ''

  editOn(item: Group) {
    this.name = item.name
    this.description = item.description
    this.dialog = false
  }

  editSubmit() {}
}
</script>
