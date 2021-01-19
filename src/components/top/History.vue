<template lang="pug">
  section.history
    h2 --- History ---
    
    v-row
      v-col(cols="12" sm="6")
        h4 九工大で16年間培ってきたシステム
        p
          | SAPは、私（当サービスの開発者）が所属していた九州工業大学情報工学部電子情報工学科（以降、電子と略す）の研究室配属で実際に使われているシステムです。
          br
          | SAPが誕生したのが2004年で、それから電子のみで使用されてきました。
          br
          | 15年間、教授達が実際に使用する中で溜め込んだノウハウを基に、全国の大学でも使用できるよう改善したものが当サービス
          br
          | 「研究室マッチングシステム」です。
      v-col(cols="12" sm="6")
        v-img(
          src="/kyukoudai.jpg"
        )
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
  width: 100%;
  height: 100vh;
  padding: 3rem;
  background-color: rgba(252, 252, 252, 0.55);
  border-radius: 2rem;

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
}
</style>
