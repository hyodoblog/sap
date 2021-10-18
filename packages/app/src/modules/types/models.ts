import admin from 'firebase/app'

// ****************************
// db
// ****************************

// common

interface Base {
  uid?: string
  createdAt?: admin.firestore.Timestamp
  updatedAt?: admin.firestore.Timestamp
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
  iconPath: string
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
  startAt: admin.firestore.Timestamp
  votingEndAt: admin.firestore.Timestamp
  browsingEndAt: admin.firestore.Timestamp
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
}

// ****************************
// /rooms/participateUsers
export interface RoomParticipateUser extends Base {
  displayName: string
  email: string
  loginToken: string
  hopeGroupUidItems: string[]
}

// ****************************
// /rooms/matchings

export interface RoomMatching extends Base {
  groupUid: string
  participateUserUidItems: string[]
}
