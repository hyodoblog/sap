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
        tr
          td
            v-avatar.logo-mini
              v-img(:src="$utils.url.getImgUrl(item.iconPath)")
          td(v-text="item.name")
          td(v-text="item.description")
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
import { ParticipateUser } from '~/modules/types/models'
const BaseMaterialCard = () => import('~/components/base/BaseMaterialCard.vue')

@Component({
  components: { BaseMaterialCard },
})
export default class RoomsTable extends Vue {
  async mounted() {
    if (this.items.length === 0) {
      this.loading = true
      await this.$store.dispatch('room/participate-user/init')
      this.loading = false
    }
  }

  get items(): ParticipateUser[] {
    return this.$store.state.room['participate-user'].items
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
      text: 'メールアドレス',
      value: 'email',
    },
  ]
}
</script>
