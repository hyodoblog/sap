import { Group, ParticipateUser, Room, User } from './models'

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

export class RoomState {
  items: Room[]

  constructor() {
    this.items = []
  }
}

export class RoomGroupState {
  items: Group[]

  constructor() {
    this.items = []
  }
}

export class RoomParticipateUserState {
  items: ParticipateUser[]

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
  room?: RoomState
  roomGroup?: RoomGroupState
  roomParticipateUser?: RoomParticipateUserState
  snackbar?: SnackbarState
}
