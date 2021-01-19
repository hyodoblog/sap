<template lang="pug">
  v-app
    div.index
      FarstView
      div#about
        About
      Service
      History
</template>

<script>
import { Component, Vue } from 'nuxt-property-decorator'
import FarstView from '~/components/top/FarstView.vue'
import About from '~/components/top/About.vue'
import History from '~/components/top/History.vue'
import Service from '~/components/top/Service.vue'

@Component({
  components: {
    FarstView,
    About,
    Service,
    History,
  },
})
export default class extends Vue {}
</script>

<style>
.index{
  background-color: gold;
}
#about{
  padding: 3rem;
}
#home {
  width: 100%;
  background-color: gold;
}
.top img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
h1 {
  text-align: center;
}
.top img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.bluebox {
  z-index: 0;
  width: 200%;
  height: 180px;
  background-color: #3bb8eb;
  transform: translate(-30%, 0) rotate(-20deg);
}
.greenbox {
  z-index: 0;
  width: 200%;
  height: 180px;
  margin-left: 0;
  background-color: #aacd02;
  transform: translate(-30%, 0) rotate(20deg);
}
.pinkbox {
  z-index: 0;
  width: 200%;
  height: 180px;
  margin: 0 auto;
  background-color: #e45f9d;
  transform: translate(-30%, 0) rotate(-20deg);
}
.about {
  position: relative;
  width: 90%;
  z-index: 1;
  padding-top: 3rem !important;
}
.service {
  position: relative;
  z-index: 1;
  padding-top: 3rem !important;
}
.history {
  position: relative;
  z-index: 1;
  padding-top: 3rem !important;
}
</style>
