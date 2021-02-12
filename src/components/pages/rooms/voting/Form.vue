<template lang="pug">
  v-form(
    ref="form"
    v-model="isValid"
    lazy-validation
  )
    draggable(v-model="items")
      v-card.pa-2.d-flex.align-center(
        v-for="(item, i) in items"
        :key="i"
      )
        span.font-weight-bold 第{{ i + 1 }}希望
        v-icon mdi-drag
        .subtitle-1.ml-2 {{ item.displayName }}
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'nuxt-property-decorator'
import { RoomGroup, RoomParticipateUser } from '~/modules/types/models'

@Component({
  components: {
    draggable: () => import('vuedraggable'),
  },
})
export default class RoomDashboardVotingFormComponnet extends Vue {
  @Prop({ type: Array, required: true }) readonly items: RoomGroup[] | RoomParticipateUser[]

  isValid = true
  isLoading = false
}
</script>
