import firebase from 'firebase/compat/app'

// ****************************
// db
// ****************************

// common

interface Base {
  uid?: string
  createdAt?: firebase.firestore.Timestamp
  updatedAt?: firebase.firestore.Timestamp
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
  startAt: firebase.firestore.Timestamp
  votingEndAt: firebase.firestore.Timestamp
  browsingEndAt: firebase.firestore.Timestamp
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
