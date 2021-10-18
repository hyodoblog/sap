<template lang="pug">
  v-navigation-drawer(v-model="drawer" app right :mobile-breakpoint="9999")
    v-list
      v-list-item-action
        v-icon.ml-3(style="font-size:32px" @click="drawer = false") mdi-window-close
      template(v-for="(item, i) in items")
        v-list-item(
          :key="i"
          :to="item.to ? item.to : ''"
          router
          exact
        )
          v-list-item-content
            v-list-item-title(v-text="item.title")
          v-list-item-action(v-if="item.to")
            v-icon.fas.fa-angle-right
</template>

<script lang="ts">
import { Component, PropSync, Vue } from 'nuxt-property-decorator'

@Component
export default class CorePublicNavigationComponent extends Vue {
  @PropSync('drawerValue', { type: Boolean || null, default: null }) drawer: boolean | null

  get items() {
    return [
      {
        title: '希望提出ページ',
        to:
          this.$routes.front.roomVoting(this.$route.params.uid) +
          '?' +
          Object.keys(this.$route.query)
            .map((key: string) => key + '=' + encodeURIComponent(this.$route.query[key] as string))
            .join('&'),
      },
      {
        title: 'マッチング一覧ページ',
        to:
          this.$routes.front.roomMatching(this.$route.params.uid) +
          '?' +
          Object.keys(this.$route.query)
            .map((key: string) => key + '=' + encodeURIComponent(this.$route.query[key] as string))
            .join('&'),
      },
      {
        title: 'v.2.0.0',
      },
    ]
  }
}
</script>
