<template>
  <div class="section">
    <h1>--- About ---</h1>
    <div id="about">
    <img src="/kougi.jpg" width="288" height="162">
    <h2>学生と教授の満足度を高める</h2>
    <a>SAP(Student Assignment
      Program)とは、研究室と学生のマッチングを行うシステムです。
      多くの大学では、大学3年次の末に卒業研究、若しくは、ゼミの為に研究室への配属が行われます。
      この研究室配属において、学生同士の相談や成績順などの単純な方法では、学生と教授双方の意向を反映させつつm配属における満足度を高めることは困難です、
      それを解決するために開発されたのが、当サービス
      「研究室マッチングシステム」です。
    </a>
    </div>
  </div>
</template>

<script>
export default {
  data: () => ({}),
}
</script>

<style>
.section {
  width: 80%;
  margin-left: 10%;
  background-color: rgba(255, 255, 255, 0.8);
}
#about{
  width: 90%;
  margin-left: 5%;
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
