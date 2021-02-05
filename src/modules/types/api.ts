import { Room, User } from './models'

// *******************
// cookie

export interface ApiCreateCookieReqParams {
  token: string
}

export interface ApiCreateCookieResParams {
  token: string
}

export interface ApiVerifyCookieReqParams {
  sessionCookie: string
  userUid: string
}

export interface ApiVerifyCookieResParams {
  user: User
}

// *******************
// room

export interface ApiCreateRoomReqParams {
  roomUid: string
  roomItem: Room
}

export interface ApiUpdateRoomReqParams {
  roomUid: string
  roomItem: Room
}
