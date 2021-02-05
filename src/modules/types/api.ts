import { Room } from './models'

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
}

// *******************
// room

export interface ApiCreateRoomReqParams {
  roomUid: string
  roomItem: Room
}
