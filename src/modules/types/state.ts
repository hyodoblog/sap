import { User } from './models'

export class AuthState {
  userUid: string | null
  user: User | null

  constructor() {
    this.userUid = null
    this.user = null
  }
}

export class SnackbarState {
  text: string
  color: string

  constructor() {
    this.text = ''
    this.color = ''
  }
}

export interface RootState {
  auth?: AuthState
  snackbar?: SnackbarState
}
