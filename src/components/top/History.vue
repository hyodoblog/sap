<template>
  <div class="section">
    <h2>--- History ---</h2>
    <div id="history">
      <div class="hisbox">
        <h4>九工大で16年間培ってきたシステム</h4>
        <p>SAPは、私（当サービスの開発者）が所属していた九州工業大学情報工学部電子情報工学科（以降、電子と略す）の研究室配属で実際に使われているシステムです。<br>
          SAPが誕生したのが2004年で、それから電子のみで使用されてきました。<br>
          15年間、教授達が実際に使用する中で溜め込んだノウハウを基に、全国の大学でも使用できるよう改善したものが当サービス
          「研究室マッチングシステム」です。</p>
      </div>
      <div class="hisbox">
        <img src="kyukoudai.jpg" />
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
#history {
  display: flex;
  width: 90%;
  margin-left: 5%;
}
.hisbox {
  position: relative;
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
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
