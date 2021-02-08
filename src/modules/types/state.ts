import { RoomGroup, RoomParticipateUser, Room, User } from './models'

export class IndexState {
  drawer: boolean

  constructor() {
    this.drawer = false
  }
}

export class UserState {
  uid: string | null
  item: User | null

  constructor() {
    this.uid = null
    this.item = null
  }
}

export class RoomState {
  items: Room[]

  constructor() {
    this.items = []
  }
}

export class RoomGroupState {
  items: RoomGroup[]

  constructor() {
    this.items = []
  }
}

export class RoomParticipateUserState {
  items: RoomParticipateUser[]

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
  // app
  index?: IndexState
  snackbar?: SnackbarState

  // /users
  user?: UserState

  // /rooms
  room?: RoomState
  roomGroup?: RoomGroupState
  roomParticipateUser?: RoomParticipateUserState
}
