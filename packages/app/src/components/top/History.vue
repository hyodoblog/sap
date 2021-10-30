<template lang="pug">
  section
    .box
    .history
      h2 --- History ---

      v-row.align-center
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
          img(src="/kyukoudai.jpg")
</template>

<script lang="ts">
import { Component, Vue } from 'nuxt-property-decorator'

@Component
export default class TopHistoryComponent extends Vue {}
</script>

<style lang="scss" scoped>
section {
  position: relative;

  @media (min-width: 0px) {
    width: 500px;
    height: 800px;
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

  .box {
    overflow: hidden;
    z-index: 0;
    background-color: #e45f9d;
    position: absolute;
    width: 200%;
    height: 180px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, 0) rotate(-50deg);

    @media (min-width: 600px) {
      transform: translate(-50%, -50%) rotate(-40deg);
      height: 240px;
    }
    @media (min-width: 960px) {
      transform: translate(-50%, -50%) rotate(-30deg);
      height: 270px;
    }
    @media (min-width: 1264px) {
      transform: translate(-50%, -50%) rotate(-20deg);
      height: 300px;
    }
  }

  .history {
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
}
</style>
