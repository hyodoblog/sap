import { Functions, httpsCallable, connectFunctionsEmulator } from 'firebase/functions'

export class FunctionsFire {
  private functions: Functions

  constructor(functions: Functions) {
    this.functions = functions
    if (process.env.NODE_ENV === 'development') {
      connectFunctionsEmulator(this.functions, 'localhost', 5001)
    }
  }

  async matching(roomUid: string) {
    const func = httpsCallable(this.functions, 'matching')
    await func({ roomUid })
  }
}
