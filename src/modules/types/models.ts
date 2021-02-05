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
export interface RoomGroup extends Base {
  iconPath: string
  name: string
  description: string
}

// ****************************
// /rooms/chats
export interface RoomChat extends Base {
  userUid: string
  content: string
}

// ****************************
// /rooms/participateUsers
export interface RoomParticipateUser extends Base {
  groupUid: string
  loginToken: string
  hopeParticipateUserUidItems: string[]
}
