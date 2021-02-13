<template lang="pug">
  v-card.pa-2
    .d-flex
      v-col.py-2(cols="5")
        .title 公開状況
      v-col.py-2(cols="7")
        .subtitle-1 {{ item.isPublic ? '公開' : '非公開' }}
    .d-flex
      v-col.py-2(cols="5")
        .title グループの最大希望提出人数
      v-col.py-2(cols="7")
        .subtitle-1 {{ item.groupHopeMaxNum === null ? '無制限' : item.groupHopeMaxNum }}
    .d-flex
      v-col.py-2(cols="5")
        .title 参加者の最大希望提出人数
      v-col.py-2(cols="7")
        .subtitle-1 {{ item.participateUserHopeMaxNum === null ? '無制限': item.participateUserHopeMaxNum }}
    .d-flex
      v-col.py-2(cols="5")
        .title 開始日時
      v-col.py-2(cols="7")
        .subtitle-1 {{ convertDatetime(item.startAt) }}
    .d-flex
      v-col.py-2(cols="5")
        .title 希望提出終了日時
      v-col.py-2(cols="7")
        .subtitle-1 {{ convertDatetime(item.votingEndAt) }}
    .d-flex
      v-col.py-2(cols="5")
        .title 閲覧終了日時
      v-col.py-2(cols="7")
        .subtitle-1 {{ convertDatetime(item.browsingEndAt) }}
</template>

<script lang="ts">
import firebase from 'firebase/app'
import { Component, Prop, Vue } from 'nuxt-property-decorator'
import { Room } from '~/modules/types/models'

@Component
export default class RoomDashboardInfo extends Vue {
  @Prop({ type: Object, required: true }) readonly item: Room

  convertDatetime(at: firebase.firestore.Timestamp): string {
    return this.$fire.store.getConvertDatetimeJa(at)
  }
}
</script>
