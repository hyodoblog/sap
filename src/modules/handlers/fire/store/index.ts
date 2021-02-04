import firebase from 'firebase/app'
import { AppDb } from './app'
import { ChatDb } from './app/chat'
import { GroupDb } from './app/group'
import { ParticipateUserDb } from './app/participate-user'
import { UserDb } from './user'

export class StoreHandler {
  public user: UserDb
  public app: AppDb
  public group: GroupDb
  public participateUser: ParticipateUserDb
  public chat: ChatDb
  public db: firebase.firestore.Firestore

  constructor(db: firebase.firestore.Firestore) {
    this.db = db
    this.user = new UserDb(db)
    this.app = new AppDb(db)
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
}
