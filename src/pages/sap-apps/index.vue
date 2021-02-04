<template lang="pug">
  v-container(fluid)
    v-row
      v-col(cols="12")
        BaseVComponent(title="SAP一覧" icon="mdi-monitor-dashboard")

      v-col.text-right(cols="12")
        v-btn(
          color="primary"
          :to="$routes.front.sapAppNew"
        ) SAPを追加する

      v-col(cols="12")
        SapAppsTable
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'
const BaseVComponent = () => import('~/components/base/BaseVComponent.vue')
const SapAppsTable = () => import('~/components/page/sap-apps/table.vue')

@Component({
  layout: 'protected',
  components: { BaseVComponent, SapAppsTable },
})
export default class SapAppsPage extends Vue {}
</script>
