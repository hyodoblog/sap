<template>
  <div class="section">
    <h1>--- Service ---</h1>
    <div id="service">
      <div class="hige">
        <img src="hige.png" />
        <h2>会員登録は1人で使用可能</h2>
        <a
          >会員登録したユーザーが管理者となります。たったの2ステップで初期設定は完了します。</a
        >
      </div>
      <div class="dc">
        <img src="dc.png" />
        <h2>いつでも希望を変更可能</h2>
        <a
          >学生は、システムの稼働期間内であればいつでも何回でも希望の研究室を変更することができます。</a
        >
      </div>
      <div class="pc">
        <img src="pc.png" />
        <h2>独自の配属アルゴリズム</h2>
        <a
          >安定結婚問題を解くアルゴリズムを応用した研究室配属アルゴリズムを用いて配属処理をしております。</a
        >
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
.hige {
  position: relative;
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
}
.dc {
  position: relative;
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
}
.pc {
  position: relative;
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
}
h1 {
  color: black;
}
h2 {
  color: black;
}
</style>
