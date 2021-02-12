<template lang="pug">
  v-form(
    ref="form"
    v-model="isValid"
    lazy-validation
  )
    .d-flex
      v-col.pa-0(cols="3")
        v-card.pa-2.d-flex.align-center(
          v-for="i in draggableItems.length"
          :key="i"
          style="height:50px"
        )
          span.body-2.font-weight-bold 第{{ i }}希望
      v-col.pa-0(cols="9")
        draggable(v-model="draggableItems")
          v-card.pa-2.d-flex.align-center(
            v-for="item in draggableItems"
            :key="item.uid"
            style="height:50px"
          )
            v-icon mdi-drag
            .body-1.font-weight-bold.ml-2 {{ item.displayName }}
    
    .text-center.my-3
      v-btn(
        large
        color="warning"
        @click="submit"
      ) 保存する
</template>

<script lang="ts">
import { Component, Prop, Vue, Watch } from 'nuxt-property-decorator'
import { RoomInvitationType, RoomGroup, RoomParticipateUser } from '~/modules/types/models'

@Component({
  components: {
    draggable: () => import('vuedraggable'),
  },
})
export default class RoomDashboardVotingFormComponnet extends Vue {
  @Prop({ type: String, required: true }) type: RoomInvitationType
  @Prop({ type: Array, required: true }) items: RoomGroup[] | RoomParticipateUser[]
  @Prop({ type: Array, required: true }) hopeUidItems: string[]

  mounted() {
    this.draggableItems = this.items
  }

  draggableItems: RoomGroup[] | RoomParticipateUser[] = []

  @Watch('items')
  changeItems(items: RoomGroup[] | RoomParticipateUser[]) {
    this.draggableItems = items
  }

  isValid = true
  isLoading = false

  submit() {
    console.log(this.draggableItems)
  }
}
</script>
