<template lang="pug">
  v-card.pa-2
    .d-flex
      v-col.py-1(cols="5")
        .title 公開状況
      v-col.py-1(cols="7")
        .subtitle-1 {{ item.isPublic ? '公開' : '非公開' }}
    
    v-col.pa-1(cols="12")
      v-card.pa-2(outlined)
        .title グループ
        .d-flex
          v-col.py-1(cols="5")
            .title 表示名
          v-col.py-1(cols="7")
            .subtitle-1 {{ item.groupDisplayName === null ? '設定なし' : item.groupDisplayName }}
        .d-flex
          v-col.py-1(cols="5")
            .title 編集権限
          v-col.py-1(cols="7")
            .subtitle-1 {{ item.groupIsEdit ? '可' : '不可' }}
        .d-flex
          v-col.py-1(cols="5")
            .title 最大希望提出人数
          v-col.py-1(cols="7")
            .subtitle-1 {{ item.groupHopeMaxNum === null ? '無制限' : item.groupHopeMaxNum }}

    v-col.pa-1(cols="12")
      v-card.pa-2(outlined)
        .title 参加者
        .d-flex
          v-col.py-1(cols="5")
            .title 表示名
          v-col.py-1(cols="7")
            .subtitle-1 {{ item.participateUserDisplayName === null ? '設定なし' : item.participateUserDisplayName }}
        .d-flex
          v-col.py-1(cols="5")
            .title 編集権限
          v-col.py-1(cols="7")
            .subtitle-1 {{ item.participateUserIsEdit ? '可' : '不可' }}
        .d-flex
          v-col.py-1(cols="5")
            .title 最大希望提出人数
          v-col.py-1(cols="7")
            .subtitle-1 {{ item.participateUserHopeMaxNum === null ? '無制限': item.participateUserHopeMaxNum }}
  
    .d-flex
      v-col.py-1(cols="5")
        .title 開始日時
      v-col.py-1(cols="7")
        .subtitle-1 {{ convertDatetime(item.startAt) }}
    .d-flex
      v-col.py-1(cols="5")
        .title 希望提出終了日時
      v-col.py-1(cols="7")
        .subtitle-1 {{ convertDatetime(item.votingEndAt) }}
    .d-flex
      v-col.py-1(cols="5")
        .title 閲覧終了日時
      v-col.py-1(cols="7")
        .subtitle-1 {{ convertDatetime(item.browsingEndAt) }}
</template>

<script lang="ts">
import { Timestamp } from 'firebase/firestore'
import { Component, Prop, Vue } from 'nuxt-property-decorator'
import { Room } from '~/modules/types/models'

@Component
export default class RoomDashboardInfo extends Vue {
  @Prop({ type: Object, required: true }) readonly item!: Room

  convertDatetime(at: Timestamp): string {
    return this.$fire.store.getConvertDatetimeJa(at)
  }
}
</script>
