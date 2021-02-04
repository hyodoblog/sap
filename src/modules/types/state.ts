import { SapApp, User } from './models'

export class AuthState {
  userUid: string | null
  user: User | null

  constructor() {
    this.userUid = null
    this.user = null
  }
}

export class IndexState {
  drawer: boolean

  constructor() {
    this.drawer = false
  }
}

export class SapAppState {
  items: SapApp[]

  constructor() {
    this.items = []
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
  index?: IndexState
  sapApp?: SapAppState
  snackbar?: SnackbarState
}
