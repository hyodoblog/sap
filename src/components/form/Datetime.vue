<template lang="pug">
  .d-flex
    label.pointer.mr-2(
      :for="datetimeId"
      slot="before"
    )
      v-icon mdi-calendar
    datetime.pointer(type="datetime" v-model="datetime" :input-id="datetimeId" format="yyyy-MM-dd HH:mm:ss")
</template>

<script lang="ts">
import { Component, Prop, PropSync, Vue } from 'nuxt-property-decorator'
import { Datetime } from 'vue-datetime'
import 'vue-datetime/dist/vue-datetime.css'

@Component({
  components: { Datetime },
})
export default class FormDatetimeComponnet extends Vue {
  @Prop({ type: String, default: 'datetime-form' }) readonly datetimeId: string
  @PropSync('datetimeValue', { type: String, required: true }) datetime: string
}
</script>
