<template lang="pug">
  datetime(type="datetime" v-model="a" format="yyyy-MM-dd HH:mm:ss")
</template>

<script lang="ts">
import { Component, PropSync, Vue } from 'nuxt-property-decorator'
import { Datetime } from 'vue-datetime'
import 'vue-datetime/dist/vue-datetime.css'

@Component({
  components: { Datetime },
})
export default class FormDatetimeComponnet extends Vue {
  // @PropSync('datetimeValue', { type: String, required: true }) datetime: string

  a = ''
}
</script>
