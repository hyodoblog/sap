import { Timestamp } from 'firebase-admin/firestore'

// ****************************
// db
// ****************************

// common

interface Base {
  uid?: string
  createdAt?: Timestamp
  updatedAt?: Timestamp
}

// ****************************
// /users
export interface User extends Base {
  email: string
  nickname: string
}

// ****************************
// /rooms

export type RoomInvitationType = 'group' | 'participateUser'

export interface Room extends Base {
  userUid: string
  name: string
  description: string
  isPublic: boolean

  // group
  groupDisplayName: string | null
  groupIsEdit: boolean
  groupHopeMaxNum: number | null

  // participate user
  participateUserDisplayName: string | null
  participateUserIsEdit: boolean
  participateUserHopeMaxNum: number | null

  // time
  startAt: Timestamp
  votingEndAt: Timestamp
  browsingEndAt: Timestamp
}

// ****************************
// /rooms/messages
export interface RoomMessage extends Base {
  displayName: string
  text: string
}

// ****************************
// /rooms/group
export interface RoomGroup extends Base {
  displayName: string
  email: string | null
  description: string | null
  maxNum: number | null
  loginToken: string
  hopeParticipateUserUidItems: string[]
  rateNum?: number
}

// ****************************
// /rooms/participateUsers
export interface RoomParticipateUser extends Base {
  displayName: string
  email: string
  loginToken: string
  hopeGroupUidItems: string[]
  rateNum?: number
}

// ****************************
// /rooms/matchings

export interface RoomMatching extends Base {
  groupUid: string
  participateUserUidItems: string[]
}
