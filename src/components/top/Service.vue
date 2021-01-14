<template>
  <div class="section">
    <h2>--- Service ---</h2>
    <div id="service">
      <div class="serbox">
        <img src="hige.png" />
        <h4>会員登録は1人で使用可能</h4>
        <p>会員登録したユーザーが管理者となります。たったの2ステップで初期設定は完了します。</p>
      </div>
      <div class="serbox">
        <img src="dc.png" />
        <h4>いつでも希望を変更可能</h4>
        <p>学生は、システムの稼働期間内であればいつでも何回でも希望の研究室を変更することができます。</p>
      </div>
      <div class="serbox">
        <img src="pc.png" />
        <h4>独自の配属アルゴリズム</h4>
        <p>安定結婚問題を解くアルゴリズムを応用した研究室配属アルゴリズムを用いて配属処理をしております。</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  components: {},
  data: () => ({}),
}
</script>

<style>
.section {
  width: 80%;
  margin-left: 10%;
  background-color: rgba(255, 255, 255, 0.8);
}
#service {
  display: flex;
  width: 90%;
  margin-left: 5%;
}
.serbox {
  position: relative;
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;

  -webkit-box-flex: 0;
    flex: 0 0 33.3333333333%;
    max-width: 33.3333333333%;
}
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
