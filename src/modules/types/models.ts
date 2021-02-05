import firebase from 'firebase/app'

// *******************
// db
// *******************

// common

interface Base {
  uid?: string
  createdAt?: firebase.firestore.Timestamp
  updatedAt?: firebase.firestore.Timestamp
}

// *******************
// /users
export interface User extends Base {
  email: string
  nickname: string
}

// *******************
// /rooms
export interface Room extends Base {
  userUid: string
  iconPath: string
  name: string
  description: string
  startAt: firebase.firestore.Timestamp
  votingEndAt: firebase.firestore.Timestamp
  browsingEndAt: firebase.firestore.Timestamp
}

// *******************
// /rooms/group
export interface Group extends Base {
  iconPath: string
  name: string
  description: string
}

// ****************************
// /rooms/chats
export interface Chat extends Base {
  userUid: string
  content: string
}

// ****************************
// /rooms/participateUsers
// uidはuserUid
export interface ParticipateUser extends Base {
  userUid: string // 検索用
  groupUid: string
  hopeUserUidItems: string[]
}
