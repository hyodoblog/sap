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

export interface ApiDeleteRoomReqParams {
  roomUid: string
}

// *******************
// invitation

export interface ApiGroupInvitationReqParams {
  roomUid: string
  groupUid: string
}

export interface ApiGroupAllInvitationReqParams {
  roomUid: string
}

export interface ApiParticipateUserInvitationReqParams {
  roomUid: string
  participateUserUid: string
}

export interface ApiParticipateUserAllInvitationReqParams {
  roomUid: string
}

export interface ApiAllInvitationReqParams {
  roomUid: string
}
