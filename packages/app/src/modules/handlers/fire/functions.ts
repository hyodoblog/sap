import firebase from 'firebase/app'

export class FunctionsFire {
  private functions: firebase.functions.Functions

  constructor(functions: firebase.functions.Functions) {
    this.functions = functions
  }

  async matching(roomUid: string) {
    const func = this.functions.httpsCallable('matching')
    await func({ roomUid })
  }
}
