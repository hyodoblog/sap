<template>
  <div class="section">
    <h1>--- About ---</h1>
    <div id="about">
      <div class="about1">
        <img src="/kougi.jpg" width="288" height="162" />
      </div>
      <div class="about2">
        <h2>学生と教授の満足度を高める</h2>
        <a
          >SAP(Student Assignment
          Program)とは、研究室と学生のマッチングを行うシステムです。<br />
          多くの大学では、大学3年次の末に卒業研究、若しくは、ゼミの為に研究室への配属が行われます。<br />
          この研究室配属において、学生同士の相談や成績順などの単純な方法では、学生と教授双方の意向を反映させつつ、配属における満足度を高めることは困難です。<br />
          それを解決するために開発されたのが、当サービス<br />
          「研究室マッチングシステム」です。
        </a>
      </div>
    </div>
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
  background-color: rgba(252, 252, 252, 0.55);
  border-radius: 2rem;
}
#about {
  display: flex;
  width: 100%;
}
.about1 {
  position: relative;
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
}
.about2 {
  position: relative;
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
}
h1 {
  text-align: center;
  color: black;
}
h2 {
  color: black;
}
a {
  color: black;
}
</style>
