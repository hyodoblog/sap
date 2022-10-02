<template lang="pug">
  .d-flex
    label.pointer.mr-2(
      :for="datetimeId"
      slot="before"
    )
      v-icon mdi-calendar
    datetime.pointer(type="datetime" v-model="datetimeToString" :input-id="datetimeId")
</template>

<script lang="ts">
import { Component, Prop, PropSync, Vue } from 'nuxt-property-decorator'
import { Datetime } from 'vue-datetime'
import 'vue-datetime/dist/vue-datetime.css'

@Component({
  components: { Datetime },
})
export default class FormDatetimeComponent extends Vue {
  @Prop({ type: String, default: 'datetime-form' }) readonly datetimeId!: string
  @PropSync('datetimeValue', { type: Date, required: true }) datetime!: Date

  get datetimeToString(): string {
    return this.datetime.toISOString()
  }

  set datetimeToString(datetime: string) {
    this.datetime = new Date(datetime)
  }
}
</script>
