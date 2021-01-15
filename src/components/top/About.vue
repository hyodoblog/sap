<template>
  <div class="section">
    <h2>--- About ---</h2>
    <div id="about">
      <div class="about_box">
        <img src="/kougi.jpg" width="288" height="162" />
      </div>
      <div class="about_box">
        <h4>学生と教授の満足度を高める</h4>
        <p>
          SAP(Student Assignment
          Program)とは、研究室と学生のマッチングを行うシステムです。<br />
          多くの大学では、大学3年次の末に卒業研究、若しくは、ゼミの為に研究室への配属が行われます。<br />
          この研究室配属において、学生同士の相談や成績順などの単純な方法では、学生と教授双方の意向を反映させつつ、配属における満足度を高めることは困難です。<br />
          それを解決するために開発されたのが、当サービス<br />
          「研究室マッチングシステム」です。
        </p>
      </div>
    </div>

    <!-- <div class="about">
      <section class="about_innerBox">
        <img class="about_innterBox-image" src="">
      </section>
      <section class="about_innerBox">
        <h1 class="about_innerBox-sectionTitle">title</h1>
      </section>
    </div> -->
  </div>
</template>

<script>
export default {
  data: () => ({}),
}
</script>

<style>
div {
  display: block;
}
.section {
  width: 100%;
  margin-left: 10%;
  padding: 3rem !important;
  background-color: rgba(252, 252, 252, 0.55);
  border-radius: 2rem;
}
#about {
  display: flex;
  width: 100%;
}
.about_box {
  /* position: relative; */
  /* width: 100%; */
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
}
#about img {
  width: 480px; /*960*/
  height: 270px; /*540*/
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
