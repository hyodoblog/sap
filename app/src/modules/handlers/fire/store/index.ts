import firebase from 'firebase/app'
import { RoomGroupDb } from './room/group'
import { RoomParticipateUserDb } from './room/participate-user'
import { RoomMessageDb } from './room/message'
import { RoomDb } from './room'
import { UserDb } from './user'

export class StoreFire {
  // users
  public user: UserDb

  // rooms
  public room: RoomDb
  public roomGroup: RoomGroupDb
  public roomParticipateUser: RoomParticipateUserDb
  public roomMessage: RoomMessageDb

  public rootRef: firebase.firestore.DocumentReference

  constructor(db: firebase.firestore.Firestore) {
    this.rootRef = db.collection('envs').doc(process.env.FIREBASE_STORE_ROOT_COLLECTION)

    // users
    this.user = new UserDb(this.rootRef)

    // rooms
    this.room = new RoomDb(this.rootRef)
    this.roomGroup = new RoomGroupDb(this.rootRef)
    this.roomParticipateUser = new RoomParticipateUserDb(this.rootRef)
    this.roomMessage = new RoomMessageDb(this.rootRef)
  }

  public getNowAtToDate(): Date {
    return firebase.firestore.Timestamp.now().toDate()
  }

  public getConvertDate(at: firebase.firestore.Timestamp): string {
    const date = at.toDate()
    return `${date.getFullYear()}/${date.getMonth() + 1}/${date.getDate()} ${date.getHours()}:${date.getMinutes()}`
  }

  public getConvertDatetimeJa(timestamp: firebase.firestore.Timestamp): string {
    const date = timestamp.toDate()
    return `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日 ${`0${date.getHours()}`.slice(
      -2
    )}時${`0${date.getMinutes()}`.slice(-2)}分`
  }

  public getConvertTimeJa(timestamp: firebase.firestore.Timestamp): string {
    const date = timestamp.toDate()
    return `${date.getMonth() + 1}月${date.getDate()}日 ${`0${date.getHours()}`.slice(
      -2
    )}時${`0${date.getMinutes()}`.slice(-2)}分`
  }

  public convertTimestamp(date: Date | number): firebase.firestore.Timestamp {
    if (typeof date === 'object') {
      return firebase.firestore.Timestamp.fromDate(date)
    } else {
      return firebase.firestore.Timestamp.fromMillis(date)
    }
  }
}
