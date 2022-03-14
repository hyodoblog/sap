import firebase from 'firebase/compat/app'
import { RoomGroupDb } from './room/group'
import { RoomParticipateUserDb } from './room/participate-user'
import { RoomMessageDb } from './room/message'
import { RoomMatchingDb } from './room/matching'
import { RoomDb } from './room'
import { UserDb } from './user'

export class StoreFire {
  // users
  user: UserDb

  // rooms
  room: RoomDb
  roomGroup: RoomGroupDb
  roomParticipateUser: RoomParticipateUserDb
  roomMessage: RoomMessageDb
  roomMatching: RoomMatchingDb

  rootRef: firebase.firestore.DocumentReference

  constructor(db: firebase.firestore.Firestore) {
    this.rootRef = db.collection('envs').doc(process.env.FIREBASE_STORE_ROOT_COLLECTION)

    // users
    this.user = new UserDb(this.rootRef)

    // rooms
    this.room = new RoomDb(this.rootRef)
    this.roomGroup = new RoomGroupDb(this.rootRef)
    this.roomParticipateUser = new RoomParticipateUserDb(this.rootRef)
    this.roomMessage = new RoomMessageDb(this.rootRef)
    this.roomMatching = new RoomMatchingDb(this.rootRef)
  }

  getNowAt(): firebase.firestore.Timestamp {
    return firebase.firestore.Timestamp.now()
  }

  getNowAtToDate(): Date {
    return firebase.firestore.Timestamp.now().toDate()
  }

  getConvertDate(at: firebase.firestore.Timestamp): string {
    const date = at.toDate()
    return `${date.getFullYear()}/${date.getMonth() + 1}/${date.getDate()} ${date.getHours()}:${date.getMinutes()}`
  }

  getConvertDatetimeJa(timestamp: firebase.firestore.Timestamp): string {
    const date = timestamp.toDate()
    return `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日 ${`0${date.getHours()}`.slice(
      -2
    )}時${`0${date.getMinutes()}`.slice(-2)}分`
  }

  getConvertTimeJa(timestamp: firebase.firestore.Timestamp): string {
    const date = timestamp.toDate()
    return `${date.getMonth() + 1}月${date.getDate()}日 ${`0${date.getHours()}`.slice(
      -2
    )}時${`0${date.getMinutes()}`.slice(-2)}分`
  }

  convertTimestamp(date: Date | number): firebase.firestore.Timestamp {
    if (typeof date === 'object') {
      return firebase.firestore.Timestamp.fromDate(date)
    } else {
      return firebase.firestore.Timestamp.fromMillis(date)
    }
  }
}
