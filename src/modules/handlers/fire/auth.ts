import firebase from 'firebase/app'

export class AuthHandler {
  private auth: firebase.auth.Auth

  constructor(auth: firebase.auth.Auth) {
    this.auth = auth
  }

  public async createCustomToken(token: string): Promise<string> {
    const res = await this.auth.signInWithCustomToken(token)
    if (!res.user) throw Error
    return res.user.uid
  }

  public async getIdToken(): Promise<string> {
    const idToken = await this.auth.currentUser?.getIdToken()
    if (!idToken) throw Error
    return idToken
  }

  public async createUserWithEmailAndPassword(email: string, password: string): Promise<firebase.User> {
    const res = await this.auth.createUserWithEmailAndPassword(email, password)
    console.log(res)
    if (!res.user) throw Error
    return res.user
  }

  public async signInWithEmailAndPassword(email: string, password: string): Promise<firebase.User> {
    const res = await this.auth.signInWithEmailAndPassword(email, password)
    if (!res.user) throw Error
    return res.user
  }

  public async signOut(): Promise<void> {
    await this.auth.signOut()
  }

  public async forgetPassword(email: string): Promise<void> {
    await this.auth.sendPasswordResetEmail(email)
  }
}
