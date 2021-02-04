import firebase from 'firebase/app'
import { ChatDb } from './sap-app/chat'
import { GroupDb } from './sap-app/group'
import { ParticipateUserDb } from './sap-app/participate-user'
import { SapAppDb } from './sap-app'
import { UserDb } from './user'

export class StoreFire {
  public user: UserDb
  public group: GroupDb
  public participateUser: ParticipateUserDb
  public chat: ChatDb
  public sapApp: SapAppDb
  public db: firebase.firestore.Firestore

  constructor(db: firebase.firestore.Firestore) {
    this.db = db

    // users
    this.user = new UserDb(db)

    // sapApps
    this.sapApp = new SapAppDb(db)
    this.group = new GroupDb(db)
    this.participateUser = new ParticipateUserDb(db)
    this.chat = new ChatDb(db)
  }

  public getNowAtToDate(): Date {
    return firebase.firestore.Timestamp.now().toDate()
  }

  public getConvertDate(at: firebase.firestore.Timestamp): string {
    const date = at.toDate()
    return `${date.getFullYear()}/${date.getMonth() + 1}/${date.getDate()} ${date.getHours()}:${date.getMinutes()}`
  }

  public getConvertTimeJa(timestamp: firebase.firestore.Timestamp): string {
    const date = timestamp.toDate()
    return `${date.getMonth() + 1}月${date.getDate()}日 ${`0${date.getHours()}`.slice(
      -2
    )}時${`0${date.getMinutes()}`.slice(-2)}}分`
  }

  public convertTimestamp(date: Date | number): firebase.firestore.Timestamp {
    if (typeof date === 'object') {
      return firebase.firestore.Timestamp.fromDate(date)
    } else {
      return firebase.firestore.Timestamp.fromMillis(date)
    }
  }
}
