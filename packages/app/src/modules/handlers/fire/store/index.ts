import { doc, DocumentReference, Firestore, Timestamp } from 'firebase/firestore'
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

  rootRef: DocumentReference

  constructor(db: Firestore) {
    this.rootRef = doc(db, 'envs', process.env.FIREBASE_STORE_ROOT_COLLECTION!)

    // users
    this.user = new UserDb(this.rootRef)

    // rooms
    this.room = new RoomDb(this.rootRef)
    this.roomGroup = new RoomGroupDb(this.rootRef)
    this.roomParticipateUser = new RoomParticipateUserDb(this.rootRef)
    this.roomMessage = new RoomMessageDb(this.rootRef)
    this.roomMatching = new RoomMatchingDb(this.rootRef)
  }

  getNowAt(): Timestamp {
    return Timestamp.now()
  }

  getNowAtToDate(): Date {
    return Timestamp.now().toDate()
  }

  getConvertDate(at: Timestamp): string {
    const date = at.toDate()
    return `${date.getFullYear()}/${date.getMonth() + 1}/${date.getDate()} ${date.getHours()}:${date.getMinutes()}`
  }

  getConvertDatetimeJa(timestamp: Timestamp): string {
    const date = timestamp.toDate()
    return `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日 ${`0${date.getHours()}`.slice(
      -2
    )}時${`0${date.getMinutes()}`.slice(-2)}分`
  }

  getConvertTimeJa(timestamp: Timestamp): string {
    const date = timestamp.toDate()
    return `${date.getMonth() + 1}月${date.getDate()}日 ${`0${date.getHours()}`.slice(
      -2
    )}時${`0${date.getMinutes()}`.slice(-2)}分`
  }

  convertTimestamp(date: Date | number): Timestamp {
    if (typeof date === 'object') {
      return Timestamp.fromDate(date)
    } else {
      return Timestamp.fromMillis(date)
    }
  }
}
