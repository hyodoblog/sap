import {
  User,
  Auth,
  signInWithCustomToken,
  ActionCodeSettings,
  sendSignInLinkToEmail,
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  sendPasswordResetEmail,
  verifyPasswordResetCode,
  isSignInWithEmailLink,
  sendEmailVerification,
} from 'firebase/auth'

export class AuthFire {
  private auth: Auth

  constructor(auth: Auth) {
    this.auth = auth
  }

  public async createCustomToken(token: string): Promise<string> {
    const res = await signInWithCustomToken(this.auth, token)
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

  public async sendSignInLinkToEmail(email: string): Promise<void> {
    const actionCodeSettings: ActionCodeSettings = {
      url: `${process.env.BASE_URL}/auth/signup`,
      handleCodeInApp: true,
    }
    await sendSignInLinkToEmail(this.auth, email, actionCodeSettings)
  }

  public async createUserWithEmailAndPassword(email: string, password: string): Promise<User> {
    const res = await createUserWithEmailAndPassword(this.auth, email, password)
    if (!res.user) throw Error
    return res.user
  }

  public async signInWithEmailAndPassword(email: string, password: string): Promise<User> {
    const res = await signInWithEmailAndPassword(this.auth, email, password)
    if (!res.user) throw Error
    return res.user
  }

  public async signOut(): Promise<void> {
    await this.auth.signOut()
  }

  public async sendPasswordResetEmail(email: string): Promise<void> {
    await sendPasswordResetEmail(this.auth, email)
  }

  public async verifyPasswordResetCode(code: string): Promise<void> {
    await verifyPasswordResetCode(this.auth, code)
  }

  public async isSignInWithEmailLink(): Promise<void> {
    await isSignInWithEmailLink(this.auth, window.location.href)
  }

  // auth

  public currentUser(): User | null {
    return this.auth.currentUser
  }

  public isEmailVerified(): boolean {
    if (!this.auth.currentUser) throw new Error('not auth.')
    return this.auth.currentUser.emailVerified
  }

  public async sendEmailVerification(): Promise<void> {
    if (!this.auth.currentUser) throw new Error('not auth.')
    await sendEmailVerification(this.auth.currentUser)
  }
}
