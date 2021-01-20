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

<script>
export default {
  components: {},
  data: () => ({}),
}
</script>

<style lang="scss" scoped>
section {
  position: relative;
  height: 100vh;

  @media (min-width: 0px) {
    width: 100%;
  }
  @media (min-width: 600px) {
    width: 600px;
  }
  @media (min-width: 960px) {
    width: 1100px;
  }
  @media (min-width: 1264px) {
    width: 1100px;
  }

  .service {
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
      font-size: 20px;
    }
  }

  .box {
    position: absolute;
    z-index: 0;
    width: 200%;
    height: 30%;
    background-color: #aacd02;
    transform: translate(-25%, 50%) rotate(20deg);
  }
}
</style>
