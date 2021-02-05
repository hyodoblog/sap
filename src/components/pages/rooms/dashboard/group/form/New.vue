<template lang="pug">
  div
    v-btn(
      color="primary"
      @click="groupDialog = true"
    ) グループ追加する
    RoomGroupDialogForm(
      :dialogValue.sync="groupDialog"
    )
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component
export default class RoomsDashboard extends Vue {
  
}
</script>
