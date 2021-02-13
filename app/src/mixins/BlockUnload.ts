import { Component, Vue } from 'nuxt-property-decorator'

@Component
export default class extends Vue {
  protected blockUnloadMessage = '編集した内容が消えちゃうけど、移動する？'
  protected isBlockUnload = false

  created() {
    if (process.client) {
      // 作成時にイベントリスナーに登録
      window.addEventListener('beforeunload', this.checkWindow)
    }
  }

  beforeDestroy() {
    // 破棄される前にイベントリスナーから削除
    window.removeEventListener('beforeunload', this.checkWindow)
  }

  // 実際の処理
  protected checkWindow(event: BeforeUnloadEvent) {
    if (this.isBlockUnload) {
      // unloadをキャンセルして、メッセージを表示
      event.preventDefault()
      event.returnValue = this.blockUnloadMessage
    }
  }

  // ****************************
  // * ページを移動するときの処理: v-router
  // ****************************
  /* eslint @typescript-eslint/no-unused-vars: 1 */
  beforeRouteLeave(to: any, from: any, next: any) {
    if (this.isBlockUnload) {
      // アラートダイアログを表示して、結果に応じて遷移
      const msg = this.blockUnloadMessage
      const answer = window.confirm(msg)
      next(answer)
    } else {
      // next()は必ず呼び出さないといけない
      next(true)
    }
  }
}
