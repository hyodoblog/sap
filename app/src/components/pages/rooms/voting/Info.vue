<template lang="pug">
  v-card.pa-2(elevation="1")
    .subtitle-1 あなたの情報

    .d-flex
      v-col.pa-1.align-center(cols="3")
        .caption 表示名
      v-col.pa-1.align-center(cols="9")
        .subtitle-2 {{ item.displayName }}

    .d-flex(v-if="!!item.email")
      v-col.pa-1.align-center(cols="3")
        .caption Eメール
      v-col.pa-1.align-center(cols="9")
        .subtitle-2 {{ item.email }}

    .d-flex(v-if="!!item.description")
      v-col.pa-1.align-center(cols="3")
        .caption 詳細
      v-col.pa-1.align-center(cols="9")
        .subtitle-2 {{ item.description }}
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'nuxt-property-decorator'
import { RoomGroup, RoomParticipateUser } from '~/modules/types/models'

@Component
export default class RoomVotingInfoComponent extends Vue {
  @Prop({ type: Object, required: true }) item: RoomGroup | RoomParticipateUser
}
</script>
