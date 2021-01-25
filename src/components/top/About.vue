<template lang="pug">
  section
    div.box
    div.about
      h2 --- About ---

      v-row
        v-col(cols="12" md="6")
          img(src="/kougi.jpg")
        v-col(cols="12" md="6")
          h4 学生と教授の満足度を高める
          p
            | SAP(Student Assignment Program)とは、研究室と学生のマッチングを行うシステムです。
            br
            | 多くの大学では、大学3年次の末に卒業研究、若しくは、ゼミの為に研究室への配属が行われます。
            br
            | この研究室配属において、学生同士の相談や成績順などの単純な方法では、学生と教授双方の意向を反映させつつ、配属における満足度を高めることは困難です。
            br
            | それを解決するために開発されたのが、当サービス
            br
            | 「研究室マッチングシステム」です。
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component
export default class TopAboutComponent extends Vue {}
</script>

<style lang="scss" scoped>
$vuetify-breakpoints: (
  'cols': 0px,
  'sm': 600px,
  'md': 960px,
  'lg': 1264px,
  'xl': 1904px,
);

section {
  position: relative;

  @media (min-width: 0px) {
    width: 500px;
    height: 700px;
  }
  @media (min-width: 600px) {
    width: 600px;
    height: 800px;
  }
  @media (min-width: 960px) {
    width: 1100px;
    height: 500px;
  }
  @media (min-width: 1264px) {
    width: 1100px;
    height: 500px;
  }

  .about {
    position: absolute;
    z-index: 1;
    background-color: rgba(252, 252, 252, 0.55);
    padding: 3rem;
    border-radius: 2rem;

    img {
      width: 100%;
      object-fit: cover;
    }
    h2 {
      text-align: center;
      color: #555;
      font-family: ヒラギノ角ゴ ProN, W3;
      font-size: 2rem;
      padding-bottom: 2rem;
    }
    h4 {
      color: #444;
      font-family: ten-mincho, serif;
      font-size: 1.5rem;
    }
    p {
      font-family: YuMincho, 'Yu Mincho', serif;
      font-size: 1rem;
    }
  }

  .box {
    position: absolute;
    z-index: 0;
    width: 200%;
    height: 30%;
    background-color: #3bb8eb;
    transform: translate(-25%, 50%) rotate(-20deg);
    // margin: 0 auto;
  }
}
</style>
