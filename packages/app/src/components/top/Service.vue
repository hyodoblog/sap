<template lang="pug">
  section
    div.box
    div.service
      h2 --- Service ---
      
      v-row
        v-col(cols="12" md="4")
          img(src="/hige.png")
          h4 会員登録は1人で使用可能
          p
            | 会員登録したユーザーが管理者となります。たったの2ステップで初期設定は完了します。
        v-col(cols="12" md="4")
          img(src="/dc.png")
          h4 いつでも希望を変更可能
          p
            | 学生は、システムの稼働期間内であればいつでも何回でも希望の研究室を変更することができます。
        v-col(cols="12" md="4")
          img(img src="/pc.png")
          h4 独自の配属アルゴリズム
          p
            | 安定結婚問題を解くアルゴリズムを応用した研究室配属アルゴリズムを用いて配属処理をしております。
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component
export default class TopServiceComponent extends Vue {}
</script>

<style lang="scss" scoped>
section {
  position: relative;

  img {
    width: 100%;
  }

  @media (min-width: 0px) {
    width: 500px;
    height: 1300px;
  }
  @media (min-width: 600px) {
    width: 600px;
    height: 1200px;
  }
  @media (min-width: 960px) {
    width: 1100px;
    height: 600px;
  }
  @media (min-width: 1264px) {
    width: 1100px;
    height: 600px;
  }

  .service {
    position: absolute;
    z-index: 1;
    background-color: rgba(252, 252, 252, 0.55);
    padding: 3rem;
    border-radius: 2rem;

    img {
      max-width: 200px;
      height: 200px;
    }
    h2 {
      text-align: center;
      color: #555;
      font-family: ヒラギノ角ゴ ProN, W3;
      font-size: 2rem;
      padding-bottom: 2rem;
    }
    h4 {
      text-align: center;
      color: #444;
      font-family: ten-mincho, serif;
      font-size: 1.5rem;
    }
    p {
      text-align: center;
      font-family: YuMincho, 'Yu Mincho', serif;
      font-size: 20px;
    }
  }

  .box {
    overflow: hidden;
    z-index: 0;
    background-color: #aacd02;
    position: absolute;
    width: 200%;
    height: 180px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, 0) rotate(50deg);

    @media (min-width: 600px) {
      transform: translate(-50%, -50%) rotate(40deg);
      height: 240px;
    }
    @media (min-width: 960px) {
      transform: translate(-50%, -50%) rotate(30deg);
      height: 270px;
    }
    @media (min-width: 1264px) {
      transform: translate(-50%, -50%) rotate(20deg);
      height: 300;
    }
  }
}
</style>
