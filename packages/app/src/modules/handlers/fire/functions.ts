import firebase from 'firebase/compat/app'

export class FunctionsFire {
  private functions: firebase.functions.Functions

  constructor(functions: firebase.functions.Functions) {
    this.functions = functions
    if (process.env.NODE_ENV === 'development') {
      this.functions.useEmulator('localhost', 5001)
    }
  }

  async matching(roomUid: string) {
    const func = this.functions.httpsCallable('matching')
    await func({ roomUid })
  }
}
