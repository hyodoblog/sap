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
export enum Gender {
  MALE = 1,
  FEMALE = 2,
  OTHER = 3,
}
export interface User extends Base {
  email: string
  nichName: string
  description: string
  gendar: Gender
}

// *******************
// /users/apps
export interface App extends Base {
  name: string
  description: string
  startAt: firebase.firestore.Timestamp
  votingEndAt: firebase.firestore.Timestamp
  browsingEndAt: firebase.firestore.Timestamp
}

// *******************
// /users/apps/group
export interface Group extends Base {
  name: string
  description: string
}

// ****************************
// /users/apps/chats
export interface Chats extends Base {
  userUid: string
  content: string
}

// ****************************
// /users/apps/participateUsers
// uidはuserUid
export interface ParticipateUser extends Base {
  groupUid: string
  hopeUserUidItems: string[]
}
