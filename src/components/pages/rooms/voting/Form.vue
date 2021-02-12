<template lang="pug">
  v-form(
    ref="form"
    v-model="isValid"
    lazy-validation
  )
    .d-flex.justify-end
      v-btn(small fab color="error" @click="$modal.show('example')")
          v-icon mdi-plus

    .d-flex
      v-col.pa-0(cols="3")
        template(v-for="i in items.length")
          v-card.pa-2.d-flex.align-center(
            v-if="i <= maxNum"
            :key="i"
            style="height:50px"
          )
            span.body-2.font-weight-bold 第{{ i }}希望
      v-col.pa-0(cols="9")
        draggable(
          v-model="draggableItems"
          :options="{animation:300}"
        )
          v-card.draggable.pa-2.d-flex.align-center(
            v-for="(item, i) in draggableItems"
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

    modal(
      name="example"
      :adaptive="true"
      :scrollable="true"
      :max-width="400"
      width="90%"
      height="auto"
    )
      v-card
        v-btn.ma-2(small fab color="error" @click="add")
          v-icon mdi-plus
        v-data-table(
          v-model="addItems"
          :headers="headers"
          :items="otherItems"
          item-key="uid"
          show-select
          hide-default-header
          hide-default-footer
        )
          template(v-slot:item="{ item, isSelected, select }")
            tr(:class="[{'v-data-table__selected': isSelected}]" @click="select(!isSelected)")
              td
                v-simple-checkbox(
                  :ripple="false"
                  :value="isSelected"
                  @input="select($event)"
                )
              td(v-text="item.displayName")
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
  @Prop({ type: Number || null, required: true, default: null }) maxNum: number | null

  @Prop({ type: Function, required: true }) submitFunc: (
    hopeItems: RoomGroup[] | RoomParticipateUser[]
  ) => Promise<void>

  // draggable items

  mounted() {
    this.draggableItems = (this.items as any[]).filter((item) => {
      for (const hopeUid of this.hopeUidItems) if (hopeUid === item.uid) return true
      return false
    })
    this.otherItems = (this.items as any[]).filter((item) => {
      let flag = 0
      for (const draggableItem of this.draggableItems) if (draggableItem.uid !== item.uid) flag += 1
      if (flag === this.draggableItems.length) return true
      else return false
    })
    this.$watch('draggableItems', this.changeDraggableItems)
  }

  draggableItems: RoomGroup[] | RoomParticipateUser[] = []

  @Watch('items')
  changeItems(items: RoomGroup[] | RoomParticipateUser[]) {
    this.draggableItems = items
  }

  // form

  isValid = true
  isLoading = false

  submit() {
    this.isValid = false
    this.isLoading = true
    return this.submitFunc(this.draggableItems)
  }

  // add modal items

  addItems: RoomGroup[] | RoomParticipateUser[] = []

  otherItems: RoomGroup[] | RoomParticipateUser[] = []
  changeDraggableItems(draggableItems: RoomGroup[] | RoomParticipateUser[]) {
    this.otherItems = (this.items as any[]).filter((item) => {
      let flag = 0
      for (const draggableItem of draggableItems) if (draggableItem.uid !== item.uid) flag += 1
      if (flag === this.draggableItems.length) return true
      else return false
    })
  }

  headers = [
    {
      text: '',
      value: 'displayName',
    },
  ]

  add() {
    const addItems = (this.items as any[]).filter((item) => {
      for (const addItem of this.addItems) if (addItem.uid === item.uid) return true
      return false
    })
    this.draggableItems = (this.draggableItems as any[]).concat(addItems)
    this.addItems = []
    this.$modal.hide('example')
  }
}
</script>
