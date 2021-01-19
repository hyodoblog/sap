<template lang="pug">
  section
    h2 --- Service ---
    
    v-row
      v-col(cols="12" sm="4")
        v-img(
          src="/hige.png"
        )
        h4 会員登録は1人で使用可能
        p
          | 会員登録したユーザーが管理者となります。たったの2ステップで初期設定は完了します。
      v-col(cols="12" sm="4")
        v-img(
          src="/dc.png"
        )
        h4 いつでも希望を変更可能
        p
          | 学生は、システムの稼働期間内であればいつでも何回でも希望の研究室を変更することができます。
      v-col(cols="12" sm="4")
        v-img(
          img src="/pc.png"
        )
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

h2 {
  text-align: center;
  color: #555;
  font-family: ヒラギノ角ゴ ProN, W3;
  font-size: 2rem;
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
</style>
