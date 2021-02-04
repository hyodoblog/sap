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

  private async getIdToken(): Promise<string> {
    const idToken = await this.auth.currentUser?.getIdToken()
    if (!idToken) throw Error
    return idToken
  }

  public async getAuthHeaders(): Promise<any> {
    const idToken = await this.getIdToken()
    return {
      Authorization: `Bearer ${idToken}`,
    }
  }

  // public async sendSignInLinkToEmail(email: string): Promise<void> {
  //   const actionCodeSettings: firebase.auth.ActionCodeSettings = {
  //     url: '',
  //   }
  //   await this.auth.sendSignInLinkToEmail(email, actionCodeSettings)
  // }

  public async createUserWithEmailAndPassword(email: string, password: string): Promise<firebase.User> {
    const res = await this.auth.createUserWithEmailAndPassword(email, password)
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

  public async sendPasswordResetEmail(email: string): Promise<void> {
    await this.auth.sendPasswordResetEmail(email)
  }

  public async verifyPasswordResetCode(code: string): Promise<void> {
    await this.auth.verifyPasswordResetCode(code)
  }

  public async isSignInWithEmailLink(): Promise<void> {
    await this.auth.isSignInWithEmailLink(window.location.href)
  }

  // auth

  public isEmailVerified(): boolean {
    if (!this.auth.currentUser) throw new Error('not auth.')
    return this.auth.currentUser.emailVerified
  }

  public async sendEmailVerification(): Promise<void> {
    if (!this.auth.currentUser) throw new Error('not auth.')
    await this.auth.currentUser.sendEmailVerification()
  }
}
