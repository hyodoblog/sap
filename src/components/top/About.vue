<template lang="pug">
  section
    h2 --- About ---
    
    v-row(justify="center" align-content="center")
      v-col(cols="12" sm="6")
        v-img(
          src="/kougi.jpg"
          width="100%"
        )
      v-col(cols="12" sm="6")
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

<script>
export default {
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
